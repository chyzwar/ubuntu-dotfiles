#!/usr/bin/env bash
# shellcheck disable=SC1090

[ -z "$PS1" ] && return

# Explicitly load dotfiles
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.alias"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.cabal"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.cargo"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.completion"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.crenv"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.function"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.go"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.grep"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.history"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.java"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.kerl"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.kiex"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.liquid"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.nodenv"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.opam"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.pager"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.pyenv"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.rbenv"
source "$HOME/MyProjects/dotfiles-ubuntu/shell/.scala"

# Maximum number of open FD
ulimit -n 1000000
