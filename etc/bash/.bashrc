#!/usr/bin/env bash
# shellcheck disable=SC1090

DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Non interactive shell dotiles
source "$DIR/../dotfiles/.nodenv"
source "$DIR/../dotfiles/.cargo"

[ -z "$PS1" ] && return

# Interactive shell dotfiles
source "$DIR/../dotfiles/.alias"
source "$DIR/../dotfiles/.cabal"
source "$DIR/../dotfiles/.cargo"
source "$DIR/../dotfiles/.completion"
source "$DIR/../dotfiles/.crenv"
source "$DIR/../dotfiles/.function"
source "$DIR/../dotfiles/.go"
source "$DIR/../dotfiles/.grep"
source "$DIR/../dotfiles/.history"
source "$DIR/../dotfiles/.java"
source "$DIR/../dotfiles/.kerl"
source "$DIR/../dotfiles/.kiex"
source "$DIR/../dotfiles/.liquid"
source "$DIR/../dotfiles/.nodenv"
source "$DIR/../dotfiles/.opam"
source "$DIR/../dotfiles/.pyenv"
source "$DIR/../dotfiles/.rbenv"
source "$DIR/../dotfiles/.scala"
source "$DIR/../dotfiles/.tfenv"
source "$DIR/../dotfiles/.direnv"

unset DIR

# Maximum number of open FD
ulimit -n 1000000

# Set default editor
export EDITOR=code
