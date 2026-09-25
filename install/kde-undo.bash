#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

# Undo ./dotfiles kde from a console. Everything is restored as files, so no
# Plasma session is needed, and none may run: kwin_wayland rewrites
# kglobalshortcutsrc and plasmashell rewrites its appletsrc from memory when
# they exit, over whatever was restored under them.

SDDM_THEME=/usr/share/sddm/themes/kubuntu
BACKUP_ROOT="$HOME/.local/state/dotfiles"
CONFIG="$HOME/.config"

case ${XDG_SESSION_TYPE:-} in
    wayland|x11)
        error "Run this from a console, not from inside Plasma: this ends the Plasma session."
        error "Press Ctrl+Alt+F3, log in, and run ./dotfiles kde-undo there."
        exit 1
        ;;
esac

# kde-backup-<timestamp> sorts by time; the oldest is the desktop as it was
# before the first ./dotfiles kde, an argument picks another one: a full path
# or a kde-backup-<timestamp> name. ./dotfiles has cd'd into the repo, so a
# relative path would not mean what it did at the prompt
if [ -n "${1:-}" ]; then
    backup_dir="$1"
    [ -d "$backup_dir" ] || backup_dir="$BACKUP_ROOT/$1"
else
    backup_dir="$(find "$BACKUP_ROOT" -maxdepth 1 -type d -name 'kde-backup-*' 2>/dev/null | sort | head -1)"
fi
if [ -z "$backup_dir" ] || [ ! -f "$backup_dir/kwinrc" ]; then
    error "No backup from ./dotfiles kde found${1:+ at $1}."
    error "Backups are in $BACKUP_ROOT/kde-backup-<timestamp>."
    exit 1
fi

info "Backups found:"
find "$BACKUP_ROOT" -maxdepth 1 -type d -name 'kde-backup-*' | sort | sed 's/^/  /'
confirm "Restore the desktop from $backup_dir? Changes made to it since are lost" || exit 0

plasma_running () { pgrep -u "$USER" -x 'kwin_wayland|plasmashell' >/dev/null; }

if plasma_running; then
    confirm "A Plasma session is still running, even if it shows nothing. End it" || exit 0
    for session in $(loginctl list-sessions --no-legend | awk -v user="$USER" '$3 == user { print $1 }'); do
        case $(loginctl show-session "$session" -p Type --value) in
            wayland|x11) loginctl terminate-session "$session" ;;
        esac
    done
    # kwin, plasmashell and the rest are user units under graphical-session.target,
    # outside the login session, so ending the session alone can leave them up
    systemctl --user stop graphical-session.target 2>/dev/null
    for _ in $(seq 20); do
        plasma_running || break
        sleep 0.5
    done
    if plasma_running; then
        error "Plasma is still running, nothing restored:"
        pgrep -a -u "$USER" -x 'kwin_wayland|plasmashell' >&2
        exit 1
    fi
fi

info "Restore the Plasma configuration"
# on every backup since the first; a file the backup lacks did not exist before
for name in plasma-org.kde.plasma.desktop-appletsrc plasmashellrc kwinrc kglobalshortcutsrc; do
    if [ -f "$backup_dir/$name" ]; then
        cp "$backup_dir/$name" "$CONFIG/$name"
    else
        rm -f "$CONFIG/$name"
    fi
done

# backups older than kde-undo have no localectl-status, and did not copy
# kxkbrc or kscreenlockerrc, so there the keys the kde script wrote are removed
full_backup=false
[ -f "$backup_dir/localectl-status" ] && full_backup=true

restore_or_delete_keys () {
    local name=$1
    shift
    if [ -f "$backup_dir/$name" ]; then
        cp "$backup_dir/$name" "$CONFIG/$name"
    elif $full_backup; then
        rm -f "$CONFIG/$name"
    else
        "$@"
    fi
}
# drop_key FILE GROUP KEY -> remove the line itself. kwriteconfig6 --delete
# writes KEY[$d] when a lower file holds the key, and that hides the value
# Kubuntu ships in /usr/share/kubuntu-default-settings instead of restoring it
drop_key () {
    local file="$CONFIG/$1"
    [ -f "$file" ] || return 0
    awk -v group="[$2]" -v key="$3" '
        /^\[/ { current = $0 }
        current == group && (index($0, key "=") == 1 || index($0, key "[") == 1) { next }
        { print }
    ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
}
kxkbrc_keys () {
    drop_key kxkbrc Layout ResetOldOptions
    drop_key kxkbrc Layout Options
}
kscreenlockerrc_keys () {
    drop_key kscreenlockerrc Greeter WallpaperPlugin
    drop_key kscreenlockerrc 'Greeter][Wallpaper][org.kde.image][General' Image
}
restore_or_delete_keys kxkbrc kxkbrc_keys
restore_or_delete_keys kscreenlockerrc kscreenlockerrc_keys

info "Restore the keymap of the login screen and the consoles"
x11_keymap () { localectl status | sed -n "s/^ *X11 $1: //p"; }
old_options=""
$full_backup && old_options="$(sed -n 's/^ *X11 Options: //p' "$backup_dir/localectl-status")"
sudo localectl set-x11-keymap "$(x11_keymap Layout)" "$(x11_keymap Model)" \
    "$(x11_keymap Variant)" "$old_options" \
    || warn "Could not set the system keymap options"
if [ -f "$backup_dir/keyboard" ]; then
    sudo cp "$backup_dir/keyboard" /etc/default/keyboard
else
    sudo sed -i 's/^XKBOPTIONS=.*/XKBOPTIONS=""/' /etc/default/keyboard
fi || warn "Could not restore /etc/default/keyboard"

info "Restore the login screen wallpaper"
if [ -f "$backup_dir/theme.conf.user" ]; then
    sudo cp "$backup_dir/theme.conf.user" "$SDDM_THEME/theme.conf.user"
else
    sudo rm -f "$SDDM_THEME/theme.conf.user"
fi || warn "Could not restore $SDDM_THEME/theme.conf.user"

info "Done. Press Ctrl+Alt+F1 for the login screen and log in again."
