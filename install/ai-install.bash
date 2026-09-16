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


if confirm "Do you want to install Codex CLI (official installer, alpha release)"; then
    # newest alpha pre-release tag, e.g. rust-v0.155.0-alpha.11 -> 0.155.0-alpha.11
    codex_tag="$(github_latest_tag openai/codex --prerelease rust-v)"
    codex_release="${codex_tag#rust-v}"
    curl -fsSL https://chatgpt.com/codex/install.sh \
        | CODEX_NON_INTERACTIVE=1 sh -s -- --release "${codex_release:-latest}"
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
