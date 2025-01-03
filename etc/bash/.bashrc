#!/usr/bin/env bash
# shellcheck disable=SC1090

DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Non interactive shell dotiles
source "$DIR/../dotfiles/.nodenv"
source "$DIR/../dotfiles/.cargo"

[ -z "$PS1" ] && return

# Interactive shell dotfiles
source "$DIR/../dotfiles/.asdf"
source "$DIR/../dotfiles/.alias"
source "$DIR/../dotfiles/.cabal"
source "$DIR/../dotfiles/.cargo"
source "$DIR/../dotfiles/.completion"
source "$DIR/../dotfiles/.crenv"
source "$DIR/../dotfiles/.function"
source "$DIR/../dotfiles/.go"
source "$DIR/../dotfiles/.grep"
source "$DIR/../dotfiles/.history"
source "$DIR/../dotfiles/.javarc"
source "$DIR/../dotfiles/.deno"
source "$DIR/../dotfiles/.liquid"
source "$DIR/../dotfiles/.nodenv"
source "$DIR/../dotfiles/.opam"
source "$DIR/../dotfiles/.pyenv"
source "$DIR/../dotfiles/.poetry"
source "$DIR/../dotfiles/.rbenv"
source "$DIR/../dotfiles/.scalarc"
source "$DIR/../dotfiles/.direnv"
source "$DIR/../dotfiles/.androidrc"
source "$DIR/../dotfiles/.hishstory"

unset DIR

# Maximum number of open FD
ulimit -n 1000000

# Set default editor
export EDITOR="code --wait"
