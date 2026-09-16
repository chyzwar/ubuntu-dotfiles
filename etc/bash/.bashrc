#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Non interactive shell dotfiles
source "$DIR/../dotfiles/.local"
source "$DIR/../dotfiles/.nodenv"
source "$DIR/../dotfiles/.cargo"
source "$DIR/../dotfiles/.bun"
source "$DIR/../dotfiles/.mise"

[ -z "$PS1" ] && return

# Interactive shell dotfiles
source "$DIR/../dotfiles/.alias"
source "$DIR/../dotfiles/.cabal"
source "$DIR/../dotfiles/.completion"
source "$DIR/../dotfiles/.function"
source "$DIR/../dotfiles/.go"
source "$DIR/../dotfiles/.grep"
source "$DIR/../dotfiles/.history"
source "$DIR/../dotfiles/.javarc"
source "$DIR/../dotfiles/.deno"
source "$DIR/../dotfiles/.liquid"
source "$DIR/../dotfiles/.opam"
source "$DIR/../dotfiles/.uv"
source "$DIR/../dotfiles/.poetry"
source "$DIR/../dotfiles/.tfenv"
source "$DIR/../dotfiles/.direnv"
source "$DIR/../dotfiles/.androidrc"
source "$DIR/../dotfiles/.hishstory"
source "$DIR/../dotfiles/.opencode"
source "$DIR/../dotfiles/.claude"

unset DIR

# Maximum number of open FD
ulimit -n 1000000 2>/dev/null

# Set default editor
export EDITOR="code --wait"

alias gti="git"
