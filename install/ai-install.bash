#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

mkdir -p "$HOME/.local/bin"


if confirm "Do you want to install Claude Code CLI (Anthropic apt repo, latest channel)"; then
    apt_keyring claude-code https://downloads.claude.ai/keys/claude-code.asc
    apt_source claude-code https://downloads.claude.ai/claude-code/apt/latest latest main
    apt_update
    apt_install claude-code
fi


if confirm "Do you want to install Claude Desktop (Anthropic apt repo, Linux beta)"; then
    apt_keyring claude-desktop https://downloads.claude.ai/claude-desktop/key.asc
    apt_source claude-desktop https://downloads.claude.ai/claude-desktop/apt/stable stable main "amd64 arm64"
    apt_update
    apt_install claude-desktop
    # Cowork runs in a QEMU/KVM VM and needs /dev/kvm and /dev/vhost-vsock
    sudo usermod -aG kvm "$USER"
fi


if confirm "Do you want to install Codex CLI (GitHub release, alpha channel)"; then
    # No deb exists; official binaries are on GitHub releases.
    codex_tag="$(github_latest_tag openai/codex --prerelease rust-v)"
    info "Installing codex $codex_tag"
    tmp="$(mktemp -d)"
    curl -fsSL "https://github.com/openai/codex/releases/download/${codex_tag}/codex-x86_64-unknown-linux-musl.tar.gz" \
        | tar xzf - -C "$tmp"
    install -m 0755 "$tmp"/codex-x86_64-unknown-linux-musl "$HOME/.local/bin/codex"
    rm -rf "$tmp"
fi


if confirm "Do you want to install OpenCode CLI (official installer)"; then
    curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path
fi


if confirm "Do you want to install OpenCode Desktop (beta channel deb)"; then
    deb_install https://opencode.ai/download/beta/linux-x64-deb opencode-desktop
fi


if confirm "Do you want to install ChatGPT Desktop (includes Codex app, preview deb)"; then
    # The deb registers OpenAI's apt repo for updates.
    deb_install https://persistent.oaistatic.com/codex-app-prod/linux/deb/latest/chatgpt_amd64.deb chatgpt
fi
