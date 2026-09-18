#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

# Qt key codes (qnamespace.h). KGlobalAccel takes a key sequence over D-Bus as
# four ints, one per key, modifiers OR-ed into the first.
QT_SHIFT=$((  0x02000000 ))
QT_CTRL=$((   0x04000000 ))
QT_ALT=$((    0x08000000 ))
QT_META=$((   0x10000000 ))
QT_KEY_META=$(( 0x01000022 ))
QT_F1=$((     0x01000030 ))
QT_A=$((      0x00000041 ))
QT_W=$((      0x00000057 ))
QT_LEFT=$((   0x01000012 ))
QT_RIGHT=$((  0x01000014 ))
QT_PGUP=$((   0x01000016 ))
QT_PGDOWN=$(( 0x01000017 ))

# kde_shortcut COMPONENT ACTION [KEYCODE...] -> rebind through KGlobalAccel
# With no key codes the action is unbound, which is how a conflict gets cleared.
# kwin_wayland owns the shortcut registry and rewrites kglobalshortcutsrc from
# memory at logout, so editing that file directly is a coin flip; this applies
# live and survives. setForeignShortcutKeys only touches the active binding, so
# "Reset to defaults" in System Settings still brings KDE's own keys back.
kde_shortcut () {
    local component=$1 action=$2 keys="" code
    shift 2
    for code in "$@"; do
        keys="$keys,([$code, 0, 0, 0],)"
    done

    gdbus call --session --dest org.kde.kglobalaccel --object-path /kglobalaccel \
        --method org.kde.KGlobalAccel.setForeignShortcutKeys \
        "['$component','$action','','']" "[${keys#,}]" >/dev/null 2>&1 \
        || { warn "Could not rebind $action"; return 1; }

    # KGlobalAccel refuses a key another action still holds, and says nothing;
    # check every key, the conflict-prone one is rarely the first
    [ $# -eq 0 ] && return 0
    local got
    got="$(gdbus call --session --dest org.kde.kglobalaccel --object-path /kglobalaccel \
        --method org.kde.KGlobalAccel.shortcutKeys "['$component','$action','','']" 2>/dev/null)"
    for code in "$@"; do
        case $got in
            *"[$code,"*) ;;
            *) warn "$action did not take all of its keys" ; return 1 ;;
        esac
    done
}

# kwin_vd METHOD [ARG...] -> call METHOD on KWin's VirtualDesktopManager
kwin_vd () {
    gdbus call --session --dest org.kde.KWin --object-path /VirtualDesktopManager \
        --method "org.kde.KWin.VirtualDesktopManager.$1" "${@:2}" 2>/dev/null
}

# kwin_vd_prop Get|Set NAME [VALUE] -> read or write one of its properties
kwin_vd_prop () {
    gdbus call --session --dest org.kde.KWin --object-path /VirtualDesktopManager \
        --method "org.freedesktop.DBus.Properties.$1" \
        org.kde.KWin.VirtualDesktopManager "${@:2}" 2>/dev/null
}

# kwin_desktops COUNT -> add or remove virtual desktops until COUNT are live
# KWin reads [Desktops] Number only at startup and reconfigure does not create
# or destroy desktops, so the count has to be converged over D-Bus
kwin_desktops () {
    local want=$1 have id_list
    mapfile -t id_list < <(kwin_vd_prop Get desktops | grep -oE "'[0-9a-f-]{36}'" | tr -d "'")
    have=${#id_list[@]}

    while [ "$have" -lt "$want" ]; do
        kwin_vd createDesktop "$have" "Desktop $(( have + 1 ))" \
            || { warn "Could not create desktop $(( have + 1 ))"; return 1; }
        have=$(( have + 1 ))
    done

    while [ "$have" -gt "$want" ]; do
        kwin_vd removeDesktop "${id_list[$(( have - 1 ))]}" \
            || { warn "Could not remove a virtual desktop"; return 1; }
        have=$(( have - 1 ))
    done
}

# gdbus marshals the key-sequence signature KGlobalAccel wants, qdbus6 prints
# raw strings for the layout script; check both before either is used, or a
# missing binary reads as a missing session below
command -v gdbus  >/dev/null 2>&1 || apt_install libglib2.0-bin
command -v qdbus6 >/dev/null 2>&1 || apt_install qdbus-qt6

# everything below talks to a live session over D-Bus; a pid check is useless
# here because plasmashell's pid changes, the bus name is the real test
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] || ! qdbus6 org.kde.plasmashell >/dev/null 2>&1; then
    warn "No running Plasma session, skipping. Run ./dotfiles kde from the desktop."
    exit 0
fi

info "Back up the current desktop configuration"
backup_dir="$HOME/.local/state/dotfiles/kde-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"
for name in plasma-org.kde.plasma.desktop-appletsrc plasmashellrc kwinrc kglobalshortcutsrc; do
    [ -f "$HOME/.config/$name" ] && cp "$HOME/.config/$name" "$backup_dir/$name"
done
# a convenience artefact only; the dump loses the system tray's contents, the
# copied files above are the backup that actually restores everything
qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.dumpCurrentLayoutJS \
    > "$backup_dir/plasma-layout.js"
[ -s "$backup_dir/plasma-layout.js" ] || warn "The layout dump came back empty"

info "Configure 4 virtual desktops in one non-wrapping row"
# the file keeps the setting for the next login, the D-Bus calls apply it now
kwriteconfig6 --file kwinrc --group Desktops --key Number 4
kwriteconfig6 --file kwinrc --group Desktops --key Rows 1
# KWin wraps around at the ends of the row by default, GNOME stops there
kwriteconfig6 --file kwinrc --group Windows --key RollOverDesktops false
kwin_desktops 4
kwin_vd_prop Set rows "<uint32 1>" >/dev/null
kwin_vd_prop Set navigationWrappingAround "<false>" >/dev/null

info "Release the keys GNOME needs from their current actions"
# Meta+PgUp and Meta+PgDown maximise and minimise out of the box, and Meta+A
# walks activities
kde_shortcut kwin "Window Maximize"
kde_shortcut kwin "Window Minimize"
kde_shortcut plasmashell "next activity"

# the top bar menu is this layout's application grid: Meta+A the GNOME way,
# keeping KDE's Alt+F1 alongside it. Bare Meta is released here too, it belongs
# to the Overview now
kde_shortcut plasmashell "activate application launcher" \
    "$(( QT_META | QT_A ))" "$(( QT_ALT | QT_F1 ))"

# Meta+1..9 activate task manager entries, and this layout has no task manager
for entry in 1 2 3 4 5 6 7 8 9; do
    kde_shortcut plasmashell "activate task manager entry $entry"
done

info "Make the Meta key open the Overview"
# a bare Meta tap is an ordinary global shortcut here, which is how Plasma
# shipped the launcher on it; kwinrc [ModifierOnlyShortcuts] is not honoured on
# 6.6, so bind the key itself. This has to follow the block above: KGlobalAccel
# refuses a key another action still holds, and bare Meta starts out claimed
kde_shortcut kwin "Overview" "$(( QT_META | QT_W ))" "$QT_KEY_META"

info "Apply the GNOME workspace keyboard map"
kde_shortcut kwin "Switch One Desktop to the Left" \
    "$(( QT_META | QT_PGUP ))"   "$(( QT_CTRL | QT_ALT | QT_LEFT ))"
kde_shortcut kwin "Switch One Desktop to the Right" \
    "$(( QT_META | QT_PGDOWN ))" "$(( QT_CTRL | QT_ALT | QT_RIGHT ))"
kde_shortcut kwin "Window One Desktop to the Left" \
    "$(( QT_META | QT_SHIFT | QT_PGUP ))"   "$(( QT_CTRL | QT_ALT | QT_SHIFT | QT_LEFT ))"
kde_shortcut kwin "Window One Desktop to the Right" \
    "$(( QT_META | QT_SHIFT | QT_PGDOWN ))" "$(( QT_CTRL | QT_ALT | QT_SHIFT | QT_RIGHT ))"

if confirm "Do you want the Overview on the top-left hot corner (GNOME Activities corner)"; then
    # 7 is ElectricTopLeft in KWin's ElectricBorder enum
    kwriteconfig6 --file kwinrc --group Effect-overview --key BorderActivate 7
fi

info "Reload the KWin configuration"
qdbus6 org.kde.KWin /KWin reconfigure

info "Rebuild the panel as a GNOME top bar"
# a JS error comes back as a D-Bus error and qdbus6 exits non-zero
if ! layout_out="$(qdbus6 org.kde.plasmashell /PlasmaShell \
    org.kde.PlasmaShell.evaluateScript \
    "$(cat "$DOTFILES_DIR/etc/plasma/gnome-layout.js")" 2>&1)"; then
    error "Plasma layout script failed: $layout_out"
    error "Restore the panels with:"
    error "  qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript \"\$(cat $backup_dir/plasma-layout.js)\""
    exit 1
fi

info "Panel rebuilt, $layout_out"

info "Bind two-finger scroll to switching workspaces"
# libinput only reports a swipe from three fingers up, two-finger movement is a
# scroll, so the wheel is the only two-finger gesture there is. These groups are
# keyed by containment type, 0 being the desktop and 1 every panel, and they sit
# at the top level of the file rather than under a containment.
wheel_key="wheel:Vertical;NoModifier"
wheel_changed=""
for type in 0 1; do
    [ "$(kreadconfig6 --file plasma-org.kde.plasma.desktop-appletsrc \
        --group ActionPlugins --group "$type" --key "$wheel_key")" \
        = org.kde.switchdesktop ] && continue
    kwriteconfig6 --file plasma-org.kde.plasma.desktop-appletsrc \
        --group ActionPlugins --group "$type" --key "$wheel_key" org.kde.switchdesktop
    wheel_changed=1
done

# containment actions are read when plasmashell starts, so it has to be told;
# only on a change, or every re-run would flicker the desktop for nothing
[ -n "$wheel_changed" ] && qdbus6 org.kde.plasmashell /PlasmaShell \
    org.kde.PlasmaShell.refreshCurrentShell

info "Previous desktop configuration saved in $backup_dir"
