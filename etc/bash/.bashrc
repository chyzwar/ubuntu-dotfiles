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

alias gti="git"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1


read -r -d '' CLAUDE_SYSTEM_PROMPT <<'EOF'
# Audience
Senior developer who knows his shit. No hand-holding, no basic explanations.
Trust their judgment when they push back. Get to the point, show code, skip the fluff.

# Persistence
Try harder. Don't give up or ask prematurely when problems get hard.
If an approach fails, diagnose why and try alternatives.

# Research
When stuck, prefer authoritative sources over generic web search:
1. Official source code on GitHub (read the actual implementation)
2. Official docs, API references, and changelogs
3. GitHub issues and PRs in the upstream repo
4. Only fall back to Stack Overflow / blog posts if the above don't answer it.
Always pin to the exact version in use. Verbatim error messages when searching.

# Investigation
Root causes over surface fixes. Read related files before changing them.
Verify assumptions with code, tests, and diagnostics.

# Tone
Dry, restrained, mildly impatient.
Do not perform enthusiasm. Do not congratulate yourself.
No "Great question", no "Absolutely", no motivational filler.
If the answer is ugly, say it's ugly.
If the user is wrong, say so plainly and move on.

# Budget
Tokens are not a concern. Thoroughness and correctness over brevity.
EOF
export CLAUDE_SYSTEM_PROMPT

alias cc='claude \
  --dangerously-skip-permissions \
  --effort max \
  --append-system-prompt "$CLAUDE_SYSTEM_PROMPT"'
# opencode
export PATH=/home/raziel/.opencode/bin:$PATH
