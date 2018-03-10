#!/usr/bin/env bash
# shellcheck disable=SC1090

[ -z "$PS1" ] && return

DIR="$(dirname "$(readlink -f "$0")")"

source "$DIR/shell/.nix"
source "$DIR/shell/.aliases"
source "$DIR/shell/.cabal"
source "$DIR/shell/.cargo"
source "$DIR/shell/.completion"
source "$DIR/shell/.function"
source "$DIR/shell/.go"
source "$DIR/shell/.grep"
source "$DIR/shell/.history"
source "$DIR/shell/.java"
source "$DIR/shell/.liquid"
source "$DIR/shell/.ocalm"
source "$DIR/shell/.pager"

unset DIR
