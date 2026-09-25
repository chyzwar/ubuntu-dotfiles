# My dotfiles, use on your own responsibility

Inspired by [dotfiles](https://dotfiles.github.io/).

Instant setup for a fresh **Kubuntu 26.04 LTS** (Plasma 6, Wayland). One branch per
Ubuntu release: `master` targets 26.04, `22.04` is the last GNOME-era snapshot,
older branches are what they say.

Includes:

- Shell configuration (bash, readline, liquidprompt, hishtory) and git configuration
- Programming languages and version managers (mise, nodenv, uv)
- AI coding tools and desktop apps
- Editors: Vim, VSCode, Zed, Sublime Text, Emacs
- A GNOME-style Plasma desktop: top bar, 4 workspaces, Meta overview, one
  wallpaper behind the login and lock screens

## Installation

On a fresh install:

```sh
git clone https://github.com/chyzwar/ubuntu-dotfiles.git
cd ubuntu-dotfiles
./dotfiles
```

This prints the list of commands. Every optional item asks Yes/No. Steps are
idempotent, re-running a command is safe. Every third-party apt repository is
one deb822 `.sources` file with its signing key embedded in `Signed-By`, written
by `apt_repo` in `install/lib.bash`: no separate keyring files, no `apt-key`.
The exception is Slack: its deb writes its own `slack.list` and keys in
`/etc/apt/trusted.gpg.d`, which apt trusts for every repository.

Helpers shared by every install script live in `install/lib.bash`.

### ./dotfiles system

Base packages and desktop software.

- Enables universe/multiverse/restricted, dist-upgrade
- curl, wget, tree, build-essential, git (+lfs, flow), mercurial, subversion, openssh, shellcheck, vim, nnn, direnv, fonts (Fira Code, Powerline)
- GitHub CLI (official apt repo), Slack (official deb, which adds its own apt repo)
- flatpak + Discover flatpak backend, Flathub, Lollypop
- snaps: snapcraft, vlc, krita, gimp, postman
- sysctl tweaks (swappiness, inotify limits) in `/etc/sysctl.d/99-dotfiles.conf`
- optional: Firefox Nightly (Mozilla apt repo), Dropbox (official apt repo), Steam, Google Chrome (deb), Brave (apt repo), Spotify, Discord (flatpak), Picard, kubectl + microk8s

### ./dotfiles pro

Programming languages and tooling, each optional.

- python via uv (3.13 managed interpreter), pipenv, poetry
- node via nodenv (22 and 24), npm, yarn, pnpm
- erlang and elixir via mise
- ocaml via opam (opam itself via mise, bwrap sandbox on)
- VirtualBox from multiverse
- rust via rustup (nightly), eza, fd-find, skim
- PHP 8.5 and composer, nginx, MariaDB
- deno, bun
- Java 8, 21, 25 (default 21), maven, gradle, ant
- scala, sbt and scala-cli via mise
- clojure and leiningen
- go
- ruby via mise (3.4)
- terraform via mise
- crystal via mise (official release tarballs)
- docker CE with buildx and compose plugins
- Android Studio (snap) with KVM
- zig via mise, both nightly `master` (default) and latest stable

### ./dotfiles ai

Official sources, deb/apt where it exists, beta channels where they exist.

- Claude Code CLI, Anthropic apt repo, `latest` channel
- Claude Desktop, Anthropic apt repo (Linux beta; Cowork needs the `kvm` group)
- Codex CLI, official installer into `~/.local/bin`
- OpenCode CLI, official installer into `~/.opencode/bin`
- OpenCode Desktop, beta deb
- ChatGPT Desktop (includes Codex app), preview deb

### ./dotfiles shell

Installs yakuake, foot, liquidprompt, hishtory and symlinks `.bashrc`, `.inputrc`,
`.gitconfig`, `.gitignore`, `.gitattributes` from `etc/` into `$HOME`.

`.bashrc` sources the fragments in `etc/dotfiles/`. Every fragment checks that its
tool exists before touching PATH or running `init`, so a shell without uv,
nodenv, mise, opam, ... starts clean.

### ./dotfiles vim

Installs Vim and symlinks `etc/vim/.vimrc` to `~/.vimrc`.

### ./dotfiles vscode

VSCode and VSCode Insiders from Microsoft's apt repository.

### ./dotfiles zed, sublime, emacs

Zed via the official installer, Sublime Text from the official apt repo (dev channel), Emacs via snap plus Spacemacs.

### ./dotfiles kde

Reshapes Plasma into the GNOME desktop: one top bar and GNOME's way of moving
between workspaces. Destructive, it removes every existing panel.

- slim top bar, menu and launchers at the left, clock centred, system tray at
  the right
- no dock, the way vanilla GNOME has none outside the overview; windows and
  applications are reached through the Overview
- 4 virtual desktops in one row, non-wrapping like GNOME's workspace strip
- Meta alone opens the Overview, `Meta+A` the top bar menu, and `Meta+1..9` are
  cleared since there is no task manager left to activate
- two-finger scroll over the desktop or the top bar switches workspace
- `Meta+PgUp`/`Meta+PgDown` and `Ctrl+Alt+Left`/`Ctrl+Alt+Right` switch
  workspace, add Shift to take the window along
- optional: Overview on the top-left hot corner
- optional: the same wallpaper behind the login and lock screens

The knobs are three constants at the top of `install/kde-install.bash`:
`DESKTOPS`, `WALLPAPER` and `SDDM_THEME`. Edit them by hand; there is no menu.
The launchers are the `launcher_list` array at the top of
`etc/plasma/gnome-layout.js`, desktop file ids under `/usr/share/applications`.
They sit in a Quick Launch applet, which shows no windows, so the bar is still
not a dock. `Meta+E` opens Dolphin from the keyboard, as Plasma ships it.

The panel layout is `etc/plasma/gnome-layout.js`, applied through
`org.kde.PlasmaShell.evaluateScript`. It builds the new panel before removing the
old ones, so re-running replaces the layout instead of stacking onto it.

There is no dock on purpose. A Plasma panel cannot be tied to the Overview the
way GNOME's dash is, and every mode that keeps a panel out of the way brings it
back on edge proximity, so there is no setting that means "only when I ask".

A two-finger *swipe* is not possible and no setting will make it so: libinput
reports two fingers as a scroll and only starts calling a movement a swipe at
three, and KWin's finger counts are compiled into the effects. So workspace
switching is bound to the wheel instead, through Plasma's `org.kde.switchdesktop`
containment action, which is what two fingers actually produce. KWin's own
four-finger swipe still works and is not touched here. Containment actions are
read when plasmashell starts, so the script restarts
`plasma-plasmashell.service`. It does not use `refreshCurrentShell`: on Plasma
6.6 that spawns a detached `plasmashell --replace` outside the systemd unit,
the unit's own process exits 0 so `Restart=on-failure` never fires, and the
replacement aborted on this machine, leaving no shell at all.

Shortcuts, the no-wrap setting, the panel and the wallpaper apply at once. The
desktop count and rows land at the next login: KWin reads `[Desktops]` once at
start and `reconfigure` does not reload it. Note that a bare Meta tap is bound
as an ordinary global shortcut on KWin's `Overview` action, the way Plasma ships
the launcher on it; `kwinrc [ModifierOnlyShortcuts]` is not honoured on Plasma
6.6 and leaves the key dead with no error.

Run it from inside a Plasma session, not a TTY or over SSH; it skips with a
warning otherwise, which is also why it is not part of `./dotfiles all`.
Shortcuts are set through KGlobalAccel rather than by writing
`kglobalshortcutsrc`, so they apply immediately: on Wayland `kwin_wayland` hosts
the shortcut registry itself and rewrites that file from memory at logout, over
anything edited by hand.

The wallpaper step takes no third-party theme. The login screen gets
`$WALLPAPER` through `$SDDM_THEME/theme.conf.user`, which sddm reads over the
packaged `theme.conf` and takes every non-empty key from; delete the `.user`
file to undo. The lock screen gets it as the `Image` key of `kscreenlockerrc`,
under `[Greeter][Wallpaper][org.kde.image][General]`; fill mode, clock and media
controls are left at their defaults. A custom `LockScreenUi.qml` is possible
but not done here: the greeter version-gates that file and falls back to Breeze
with nothing but a log line when a Plasma release moves the API. The login
screen shows at the next log out; autologin is not touched.

`~/.config/kwinrc`, `kglobalshortcutsrc`, `plasmashellrc` and
`plasma-org.kde.plasma.desktop-appletsrc` are copied to
`~/.local/state/dotfiles/kde-backup-<timestamp>/` first. To undo, copy them back
and `systemctl --user restart plasma-plasmashell.service`. The
`plasma-layout.js` saved alongside them replays through `evaluateScript` for a
quick panel-only restore, but it does not carry the system tray's contents.

Do not apply a Global Theme afterwards, `plasma-apply-lookandfeel` resets the
panel layout.

### ./dotfiles all

Runs everything above except `kde`, which needs a running Plasma session and
replaces the panels, so it stays an explicit choice.

## Post install

1. Install DoH proxy

   - https://developers.cloudflare.com/1.1.1.1/encrypted-dns/dns-over-https/dns-over-https-client
   - https://github.com/DNSCrypt/dnscrypt-proxy/wiki/installation

2. Change audio sample rate to 24bit

   - https://askubuntu.com/questions/868842/pros-cons-of-running-pulseaudio-at-24-bits-to-match-hardware

3. Install Mullvad

4. Log out and back in so the `docker`, `kvm`, `libvirt`, `vboxusers` group changes apply.
