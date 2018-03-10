#!/usr/bin/env bash

[ -z "$PS1" ] && return

source "$HOME/.liquidprompt/liquidprompt"


# source "$HOME/.nix-profile/etc/profile.d/nix.sh"




# READLINK=$(which greadlink || which readlink)

# if $SHELL_BASH; then
#     CURRENT_SCRIPT=${BASH_SOURCE}
# else
#     CURRENT_SCRIPT=${0}
# fi

# if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
#     SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
#     DOTFILES_DIR=$(dirname ${SCRIPT_PATH})
# else
#     echo "Unable to find dotfiles, exiting."
#     return # `exit 1` would quit the shell itself
# fi

# for DOTFILE in "$DOTFILES_DIR"/system/.{env,completion,function,path,alias,pager,completion,grep,liquid}; do
#     [ -f "$DOTFILE" ] && source "$DOTFILE"
# done

# for DOTFILE in "$DOTFILES_DIR"/bash/.*; do
#     [ -f "$DOTFILE" ] && source "$DOTFILE"
# done


# for DOTFILE in "$DOTFILES_DIR"/lang/.*; do
#     [ -f "$DOTFILE" ] && source "$DOTFILE"
# done


# # Clean up
# unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE

# # Export
# export SHELL_BASH DOTFILES_DIR

# ulimit -n 10000
