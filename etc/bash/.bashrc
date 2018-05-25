#!/usr/bin/env bash
# shellcheck disable=SC1090

[ -z "$PS1" ] && return

# Explicitly load dotfiles
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.alias"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.cabal"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.cargo"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.completion"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.crenv"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.function"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.go"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.grep"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.history"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.java"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.kerl"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.kiex"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.liquid"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.nodenv"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.opam"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.pager"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.pyenv"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.rbenv"
source "$HOME/MyProjects/dotfiles-ubuntu/etc/shell/.scala"

# Maximum number of open FD
ulimit -n 1000000
