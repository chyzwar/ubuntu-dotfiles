#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

info "Enable universe, multiverse and restricted"
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y restricted

info "Upgrade system"
apt_update
sudo apt-get dist-upgrade -y

info "Install base packages"
apt_install \
    curl wget tree build-essential ppa-purge \
    git git-lfs git-flow mercurial subversion \
    openssh-client openssh-server \
    shellcheck snapd libssl-dev \
    fonts-firacode fonts-powerline \
    nnn direnv bash-completion vim \
    flatpak plasma-discover-backend-flatpak

info "Install GitHub CLI (official apt repo)"
apt_repo github-cli https://cli.github.com/packages/githubcli-archive-keyring.gpg https://cli.github.com/packages stable main
apt_update
apt_install gh

info "Install snapcraft"
snap_install snapcraft --classic

info "Add Flathub"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

info "Install Lollypop (music player)"
flatpak install -y --noninteractive flathub org.gnome.Lollypop

info "Install vlc, krita, gimp, postman"
snap_install vlc
snap_install krita
snap_install gimp
snap_install postman

info "Install Slack (official deb)"
# there is no stable latest link, the download page carries the versioned one
slack_url="$(curl -fsSL 'https://slack.com/downloads/instructions/linux?ddl=1&build=deb' \
    | grep -oE 'https://downloads\.slack-edge\.com/desktop-releases/linux/x64/[^"]+\.deb' \
    | head -1)"
if [ -n "$slack_url" ]; then
    deb_install "$slack_url" slack-desktop
    # the deb adds its own apt repo and keys from cron.daily; now, not tomorrow
    sudo /etc/cron.daily/slack
else
    warn "Could not find the Slack deb on slack.com"
fi

info "Kernel tweaks (sysctl)"

# inotify limits for file watchers (default 8192 / 16384 / 128)
sysctl_set fs.inotify.max_user_watches 524288
sysctl_set fs.inotify.max_queued_events 32768
sysctl_set fs.inotify.max_user_instances 256


if confirm "Do you want to install Dropbox (official apt repo)"; then
    apt_repo dropbox https://linux.dropbox.com/fedora/rpm-public-key.asc \
        https://linux.dropbox.com/ubuntu "$(ubuntu_codename)" main
    apt_update
    apt_install dropbox
    # the deb only ships the CLI; first launch from the menu downloads the daemon
fi


if confirm "Do you want to install Steam"; then
    sudo dpkg --add-architecture i386
    apt_update
    apt_install steam-installer
fi


if confirm "Do you want to install Google Chrome"; then
    deb_install https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb google-chrome
fi


if confirm "Do you want to install Brave"; then
    apt_repo brave-browser-release \
        https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
        https://brave-browser-apt-release.s3.brave.com stable main "amd64 arm64"
    sudo rm -f /usr/share/keyrings/brave-browser-archive-keyring.gpg
    apt_update
    apt_install brave-browser
fi

if confirm "Do you want to install Spotify"; then
    snap_install spotify
fi


if confirm "Do you want to install Discord (flatpak, auto-updates)"; then
    flatpak install flathub com.discordapp.Discord
fi


if confirm "Do you want to install Picard"; then
    snap_install picard --classic
fi


if confirm "Do you want to install Kube tools (kubectl and microk8s)"; then
    snap_install kubectl --classic
    snap_install microk8s --classic
fi
