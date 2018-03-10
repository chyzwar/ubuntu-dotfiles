#!/usr/bin/env bash

[ -z "$PS1" ] && return

DIR="$(dirname "$(readlink -f "$0")")"

for DOTFILE in "$DIR"/shell/.*; do
    [ -f "$DOTFILE" ] && source "$DOTFILE"
done

unset DIR
