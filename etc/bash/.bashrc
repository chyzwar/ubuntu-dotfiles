#!/usr/bin/env bash
# shellcheck disable=SC1090

[ -z "$PS1" ] && return

DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

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
source "$DIR/../dotfiles/.pager"
source "$DIR/../dotfiles/.pyenv"
source "$DIR/../dotfiles/.rbenv"
source "$DIR/../dotfiles/.scala"

# Maximum number of open FD
ulimit -n 1000000

# Set default editor
export EDITOR=subl
