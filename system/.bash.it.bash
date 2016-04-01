
# Path to the bash it configuration
export BASH_IT="/home/raziel/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='powerline-plain'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Set this to the command you use for todo.txt-cli
export TODO="todo"

# Set this to false to turn off version control status
export SCM_CHECK=true

# Load Bash It
source $BASH_IT/bash_it.sh
