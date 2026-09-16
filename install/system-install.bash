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

info "Install Slack"
snap_install slack --classic

info "Kernel tweaks (sysctl)"

# inotify limits for file watchers (default 8192 / 16384 / 128)
sysctl_set fs.inotify.max_user_watches 524288
sysctl_set fs.inotify.max_queued_events 32768
sysctl_set fs.inotify.max_user_instances 256


if confirm "Do you want to install Zeal - offline documentation"; then
    apt_install zeal
fi


if confirm "Do you want to disable CPU mitigations (mitigations=off)"; then
    if grep -q 'mitigations=off' /etc/default/grub; then
        info "mitigations=off already present"
    else
        sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 mitigations=off"/' /etc/default/grub
        sudo update-grub
    fi
fi



if confirm "Do you want to install Dropbox (official apt repo)"; then
    apt_keyring dropbox https://linux.dropbox.com/fedora/rpm-public-key.asc
    apt_source dropbox https://linux.dropbox.com/ubuntu "$(ubuntu_codename)" main
    apt_update
    apt_install dropbox
    # downloads the proprietary daemon into ~/.dropbox-dist
    dropbox start -i
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
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
        https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources \
        https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
    apt_update
    apt_install brave-browser
fi

if confirm "Do you want to install Spotify"; then
    snap_install spotify
fi


if confirm "Do you want to install Discord"; then
    deb_install "https://discord.com/api/download?platform=linux&format=deb" discord
fi


if confirm "Do you want to install Picard"; then
    snap_install picard --classic
fi


if confirm "Do you want to install Kube tools (kubectl and microk8s)"; then
    snap_install kubectl --classic
    snap_install microk8s --classic
fi
