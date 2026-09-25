#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

# Find out why a Plasma login fails. SDDM starts the session through
# `bash --login -c`, so everything the profile and .bashrc do happens before
# startplasma-wayland; `on` traces that, `report` collects it with the journal
# and the core dumps, `off` removes the trace again.

STATE_DIR="$HOME/.local/state/dotfiles/kde-debug"
BEGIN_MARK="# >>> dotfiles kde-debug"
END_MARK="# <<< dotfiles kde-debug"

# bash --login reads only the first of these that exists
login_file () {
    local name
    for name in .bash_profile .bash_login .profile; do
        [ -f "$HOME/$name" ] && { echo "$HOME/$name"; return; }
    done
    echo "$HOME/.profile"
}

# drop both blocks; cat > keeps the file's owner, mode and a symlink
strip_blocks () {
    local file=$1 tmp
    tmp="$(mktemp)"
    awk -v begin="$BEGIN_MARK" -v end="$END_MARK" '
        index($0, begin) == 1 { skip = 1; next }
        index($0, end) == 1   { skip = 0; next }
        !skip { print }
    ' "$file" > "$tmp" && cat "$tmp" > "$file"
    rm -f "$tmp"
}

debug_on () {
    local file
    file="$(login_file)"
    touch "$file"
    strip_blocks "$file"

    local tmp
    tmp="$(mktemp)"
    # a non-interactive login shell is the SDDM one; a console or ssh login
    # sets PS1 and is left alone. unset BASH_XTRACEFD also closes fd 9, so
    # the session does not inherit it
    cat > "$tmp" <<'EOF'
# >>> dotfiles kde-debug: trace the desktop login, ./dotfiles kde-debug off removes it
if [ -n "$BASH_VERSION" ] && [ -z "$PS1" ]; then
    _kde_debug_dir="$HOME/.local/state/dotfiles/kde-debug"
    _kde_debug_ts="$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$_kde_debug_dir"
    exec 9>"$_kde_debug_dir/login-trace-$_kde_debug_ts.log"
    BASH_XTRACEFD=9
    PS4='+ ${BASH_SOURCE}:${LINENO}: '
    set -x
fi
# <<< dotfiles kde-debug
EOF
    cat "$file" >> "$tmp"
    cat >> "$tmp" <<'EOF'
# >>> dotfiles kde-debug: end of the trace, and the environment the session gets
if [ -n "${_kde_debug_ts:-}" ]; then
    set +x
    unset BASH_XTRACEFD
    env | sort > "$_kde_debug_dir/login-env-$_kde_debug_ts.log"
    unset _kde_debug_dir _kde_debug_ts
fi
# <<< dotfiles kde-debug
EOF
    cat "$tmp" > "$file"
    rm -f "$tmp"

    info "Login trace on in $file"
    info "Log in from the login screen (Ctrl+Alt+F1), then come back here and run ./dotfiles kde-debug report"
}

debug_off () {
    local name
    for name in .bash_profile .bash_login .profile; do
        [ -f "$HOME/$name" ] && strip_blocks "$HOME/$name"
    done
    info "Login trace off. Traces stay in $STATE_DIR"
}

latest () { find "$STATE_DIR" -maxdepth 1 -name "$1" 2>/dev/null | sort | tail -1; }
section () { printf '\n===== %s =====\n' "$*"; }
# names that look like credentials keep the name only
redact () { sed -E 's/^([^=]*(TOKEN|SECRET|PASSW|API_?KEY|PRIVATE)[^=]*)=.*/\1=<redacted>/I'; }

debug_report () {
    command -v gdb >/dev/null 2>&1 \
        || { confirm "Install gdb, for a backtrace with symbols" && apt_install gdb; }

    mkdir -p "$STATE_DIR"
    local report trace env_log
    report="$STATE_DIR/report-$(date +%Y%m%d-%H%M%S).txt"
    trace="$(latest 'login-trace-*.log')"
    env_log="$(latest 'login-env-*.log')"

    info "Collect the report, the backtrace can take a minute"
    {
        section system
        hostnamectl
        plasmashell --version
        kwin_wayland --version
        section gpu
        lspci -nnk | grep -A3 -Ei 'vga|3d|display'
        section disks
        lsblk -o NAME,TYPE,FSTYPE,SIZE,MOUNTPOINTS

        section login files
        ls -la "$HOME"/.profile "$HOME"/.bash_profile "$HOME"/.bash_login "$HOME"/.bashrc 2>&1
        section dotfiles repo
        git -C "$DOTFILES_DIR" log --oneline -1
        git -C "$DOTFILES_DIR" status --short
        git -C "$DOTFILES_DIR" diff -- etc/bash
        section per-user startup
        ls -la "$HOME/.config/autostart" "$HOME/.config/plasma-workspace/env" \
            "$HOME/.config/environment.d" 2>&1
        section programs ahead of /usr/bin
        ls "$HOME/.local/bin" "$HOME/.local/share/mise/shims" "$HOME/.cargo/bin" \
            "$HOME/.bun/bin" "$HOME/.nodenv/shims" 2>&1

        section "login trace ${trace:-(none, run ./dotfiles kde-debug on and log in)}"
        [ -n "$trace" ] && cat "$trace"
        section "session environment ${env_log:-(none)}"
        [ -n "$env_log" ] && redact < "$env_log"
        section sddm session log
        cat "$HOME/.local/share/sddm/wayland-session.log" 2>&1

        section journal, this boot
        journalctl --user -b --no-pager \
            -u plasma-plasmashell.service -u plasma-kwin_wayland.service | tail -300
        journalctl --user -b --no-pager | grep -E 'drkonqi|KCrash' | tail -30

        section core dumps
        coredumpctl list --no-pager plasmashell kwin_wayland 2>&1 | tail -20
        # qFatal reaches the journal as plain stderr at info priority, so the
        # reason for an abort is only found by the process that wrote it
        local pid
        for pid in $(coredumpctl --json=short list plasmashell 2>/dev/null \
            | python3 -c 'import json, sys; print(*[e["pid"] for e in json.load(sys.stdin)][-3:])'); do
            section "last output of plasmashell $pid, before it dumped core"
            journalctl --user --no-pager _PID="$pid" | tail -40
        done
        section plasmashell core, last
        coredumpctl info --no-pager plasmashell 2>&1 \
            | grep -E -A60 'Signal:|Stack trace of thread' | head -120
        if command -v gdb >/dev/null 2>&1; then
            section plasmashell backtrace, symbols from debuginfod
            coredumpctl debug --no-pager --debugger=gdb \
                -A "-batch -iex 'set debuginfod enabled on' -ex bt" plasmashell 2>&1 \
                | grep -vE '^Downloading|^\[New LWP|^[[:space:]]*$'
        fi
    } > "$report" 2>&1

    info "Report in $report"
    if gh auth status >/dev/null 2>&1 \
        && confirm "Upload the report as a secret gist (the link is private, not access-controlled)"; then
        gh gist create --secret "$report"
    fi
}

case ${1:-} in
    on)     debug_on ;;
    off)    debug_off ;;
    report) debug_report ;;
    *)
        echo "Usage: ./dotfiles kde-debug on|off|report"
        echo "   on       trace the next desktop logins (profile, .bashrc, environment)"
        echo "   report   collect traces, journal and plasmashell backtrace into one file"
        echo "   off      remove the trace from the login profile"
        exit 1
        ;;
esac
