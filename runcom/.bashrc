# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Shell
if [ -n "$ZSH_VERSION" ]; then
   SHELL_ZSH=true
   SHELL_BASH=false
elif [ -n "$BASH_VERSION" ]; then
   SHELL_BASH=true
   SHELL_ZSH=false
fi


# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)
READLINK=$(which greadlink || which readlink)
if $SHELL_BASH; then
    CURRENT_SCRIPT=${BASH_SOURCE}
else
    CURRENT_SCRIPT=${0}
fi

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
    SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
    DOTFILES_DIR=$(dirname $(dirname ${SCRIPT_PATH}))
else
    echo "Unable to find dotfiles, exiting."
    return # `exit 1` would quit the shell itself
fi

# Finally we can source the dotfiles (order matters)
for DOTFILE in "$DOTFILES_DIR"/system/.{env,prompt,function,path,alias,completion,grep,custom}; do
    [ -f "$DOTFILE" ] && source "$DOTFILE"
done

# Source bash dotfiles
if $SHELL_BASH; then
    for DOTFILE in "$DOTFILES_DIR"/system/.*.bash; do
        [ -f "$DOTFILE" ] && source "$DOTFILE"
    done
fi

# Source zhs dotfiles
if $SHELL_ZSH; then
    for DOTFILE in "$DOTFILES_DIR"/system/.*.zsh; do
        [ -f "$DOTFILE" ] && source "$DOTFILE"
    done
fi

# Source development dotfiles
for DOTFILE in "$DOTFILES_DIR"/dev/.*; do
    [ -f "$DOTFILE" ] && source "$DOTFILE"
done

# Source autocomplete dotfiles
for DOTFILE in "$DOTFILES_DIR"/autocomplete/.*; do
    [ -f "$DOTFILE" ] && source "$DOTFILE"
done

# Source vim dotfiles
for DOTFILE in "$DOTFILES_DIR"/vim/.*; do
    [ -f "$DOTFILE" ] && source "$DOTFILE"
done

# Clean up
unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE

# Export
export SHELL_BASH SHELL_ZSH OS DOTFILES_DIR

ulimit -n 10000
