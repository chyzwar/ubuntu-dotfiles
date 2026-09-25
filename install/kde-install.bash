#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

# the knobs; edit by hand
DESKTOPS=4
WALLPAPER=/usr/share/wallpapers/Orionids/contents/images_dark/5120x2880.png
SDDM_THEME=/usr/share/sddm/themes/kubuntu

# Qt key codes (qnamespace.h); KGlobalAccel wants [key, 0, 0, 0] per key
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

# kde_shortcut COMPONENT ACTION [KEYCODE...] -> rebind through KGlobalAccel,
# no keys unbinds. kwin_wayland rewrites kglobalshortcutsrc from memory at
# logout, so the file is not a safe place to write.
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

    # a key another action still holds is refused silently, so read back
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

command -v gdbus  >/dev/null 2>&1 || apt_install libglib2.0-bin
command -v qdbus6 >/dev/null 2>&1 || apt_install qdbus-qt6

# everything below talks to a live session over D-Bus
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] || ! qdbus6 org.kde.plasmashell >/dev/null 2>&1; then
    warn "No running Plasma session, skipping. Run ./dotfiles kde from the desktop."
    exit 0
fi

info "Back up the current desktop configuration"
backup_dir="$HOME/.local/state/dotfiles/kde-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"
for name in plasma-org.kde.plasma.desktop-appletsrc plasmashellrc kwinrc kglobalshortcutsrc kxkbrc kscreenlockerrc; do
    [ -f "$HOME/.config/$name" ] && cp "$HOME/.config/$name" "$backup_dir/$name"
done
# the system side, for ./dotfiles kde-undo; localectl-status also marks a
# backup that holds all of this
localectl status > "$backup_dir/localectl-status"
cp /etc/default/keyboard "$backup_dir/keyboard"
[ -f "$SDDM_THEME/theme.conf.user" ] && cp "$SDDM_THEME/theme.conf.user" "$backup_dir/theme.conf.user"
# a convenience only, the dump loses the system tray's contents
qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.dumpCurrentLayoutJS \
    > "$backup_dir/plasma-layout.js"
[ -s "$backup_dir/plasma-layout.js" ] || warn "The layout dump came back empty"

info "Configure $DESKTOPS virtual desktops in one non-wrapping row"
# KWin reads count and rows once at start, so they land at the next login
kwriteconfig6 --file kwinrc --group Desktops --key Number "$DESKTOPS"
kwriteconfig6 --file kwinrc --group Desktops --key Rows 1
kwriteconfig6 --file kwinrc --group Windows --key RollOverDesktops false

info "Release the keys GNOME needs from their current actions"
kde_shortcut kwin "Window Maximize"
kde_shortcut kwin "Window Minimize"
kde_shortcut plasmashell "next activity"
# Meta+A the GNOME way, Alt+F1 kept; bare Meta is released for the Overview
kde_shortcut plasmashell "activate application launcher" \
    "$(( QT_META | QT_A ))" "$(( QT_ALT | QT_F1 ))"
# this layout has no task manager
for entry in 1 2 3 4 5 6 7 8 9; do
    kde_shortcut plasmashell "activate task manager entry $entry"
done

info "Make the Meta key open the Overview"
# kwinrc [ModifierOnlyShortcuts] is not honoured on 6.6, so bind the key
# itself; this has to follow the release above, bare Meta starts out claimed
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
    # 7 is ElectricTopLeft
    kwriteconfig6 --file kwinrc --group Effect-overview --key BorderActivate 7
fi

info "Disable Caps Lock"
# KWin ignores Options unless ResetOldOptions is set, and it watches kxkbrc,
# so --notify applies the keymap at once
kwriteconfig6 --file kxkbrc --group Layout --key ResetOldOptions true
kwriteconfig6 --file kxkbrc --group Layout --key Options caps:none --notify
# SDDM and startplasma-wayland read the keymap from locale1, which Ubuntu
# keeps in /etc/vconsole.conf; localed replaces the whole keymap, so pass the
# current layout, model and variant back
x11_keymap () { localectl status | sed -n "s/^ *X11 $1: //p"; }
sudo localectl set-x11-keymap "$(x11_keymap Layout)" "$(x11_keymap Model)" \
    "$(x11_keymap Variant)" caps:none \
    || warn "Could not set the system keymap options"
# localed does not write /etc/default/keyboard, and console-setup reads only it
{ sudo sed -i '/^XKBOPTIONS=/d' /etc/default/keyboard \
    && echo 'XKBOPTIONS="caps:none"' | sudo tee -a /etc/default/keyboard >/dev/null; } \
    || warn "Could not set XKBOPTIONS for the consoles"

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
# libinput reports two fingers as a scroll, so the wheel is the gesture;
# the groups are keyed by containment type, 0 the desktop and 1 every panel
for type in 0 1; do
    kwriteconfig6 --file plasma-org.kde.plasma.desktop-appletsrc \
        --group ActionPlugins --group "$type" --key "wheel:Vertical;NoModifier" org.kde.switchdesktop
done
# containment actions are read at start. Not refreshCurrentShell: on 6.6 that
# is a detached `plasmashell --replace` outside the systemd unit, and it aborted
systemctl --user restart plasma-plasmashell.service

if confirm "Do you want the Orionids wallpaper behind the login and lock screens"; then
    # sddm reads theme.conf.user over theme.conf; delete the file to undo
    printf '[General]\nbackground=%s\n' "$WALLPAPER" \
        | sudo tee "$SDDM_THEME/theme.conf.user" >/dev/null \
        || warn "Could not write $SDDM_THEME/theme.conf.user"
    # read at every lock; fill mode, clock and media controls are the defaults
    kwriteconfig6 --file kscreenlockerrc --group Greeter --key WallpaperPlugin org.kde.image
    kwriteconfig6 --file kscreenlockerrc --group Greeter --group Wallpaper \
        --group org.kde.image --group General --key Image "file://$WALLPAPER"
fi

info "Previous desktop configuration saved in $backup_dir"
