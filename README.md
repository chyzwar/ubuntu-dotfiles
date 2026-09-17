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

## Installation

On a fresh install:

```sh
git clone https://github.com/chyzwar/ubuntu-dotfiles.git
cd ubuntu-dotfiles
./dotfiles
```

This prints the list of commands. Every optional item asks Yes/No. Steps are
idempotent, re-running a command is safe. All third-party apt repositories use
deb822 `.sources` files with `Signed-By` keyrings (no `apt-key`).

Helpers shared by every install script live in `install/lib.bash`.

### ./dotfiles system

Base packages and desktop software.

- Enables universe/multiverse/restricted, dist-upgrade
- curl, wget, tree, build-essential, git (+lfs, flow), mercurial, subversion, openssh, shellcheck, vim, nnn, direnv, fonts (Fira Code, Powerline)
- flatpak + Discover flatpak backend, Flathub, Lollypop
- snaps: snapcraft, vlc, krita, gimp, postman, slack
- sysctl tweaks (swappiness, inotify limits) in `/etc/sysctl.d/99-dotfiles.conf`
- optional: Zeal, `mitigations=off`, Firefox Nightly (Mozilla apt repo), Dropbox (official apt repo), Steam, Google Chrome (deb), Brave (apt repo), Spotify, Discord (deb), Picard, kubectl + microk8s

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
- roc (official installer, nightly build into `~/.local/bin`)

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

### ./dotfiles all

Runs everything above.

## Post install

1. Install DoH proxy

   - https://developers.cloudflare.com/1.1.1.1/encrypted-dns/dns-over-https/dns-over-https-client
   - https://github.com/DNSCrypt/dnscrypt-proxy/wiki/installation

2. Change audio sample rate to 24bit

   - https://askubuntu.com/questions/868842/pros-cons-of-running-pulseaudio-at-24-bits-to-match-hardware

3. Install Mullvad

4. Log out and back in so the `docker`, `kvm`, `libvirt`, `vboxusers` group changes apply.
