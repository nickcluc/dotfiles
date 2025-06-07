# ------------------------------------------------------------------------------
# Environment Variables & PATH Management
# ------------------------------------------------------------------------------

# Export path to root of dotfiles repo
export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Extend $PATH without duplicates
_extend_path() {
  [[ -d "$1" ]] || return

  if ! $( echo "$PATH" | tr ":" "\n" | grep -qx "$1" ) ; then
    export PATH="$1:$PATH"
  fi
}

# Core PATH additions
_extend_path "$HOME/.local/bin"
_extend_path "$DOTFILES/bin"
_extend_path "$HOME/bin"

# Node.js and package managers
_extend_path "$HOME/.npm-global/bin"
_extend_path "$HOME/.yarn/bin"
_extend_path "$HOME/.config/yarn/global/node_modules/.bin"
_extend_path "$HOME/.bun/bin"

# Ruby
_extend_path "$HOME/.rvm/bin"

# Docker
_extend_path "$HOME/.docker/bin"

# Android development
_extend_path "$HOME/Library/Android/sdk/platform-tools"
_extend_path "$HOME/Downloads/platform-tools"

# PostgreSQL
_extend_path "/opt/homebrew/opt/postgresql@16/bin"
_extend_path "/opt/homebrew/opt/postgresql@14/bin"

# ICU
_extend_path "/opt/homebrew/opt/icu4c@74/bin"
_extend_path "/opt/homebrew/opt/icu4c@74/sbin"

# Development tools
_extend_path "$HOME/.qlty/bin"

# Extend $NODE_PATH
if [ -d ~/.npm-global ]; then
  export NODE_PATH="$NODE_PATH:$HOME/.npm-global/lib/node_modules"
fi

# ------------------------------------------------------------------------------
# Tool-specific Environment Variables
# ------------------------------------------------------------------------------

# Default pager
export PAGER="less"

# less options
less_opts=(
  # Quit if entire file fits on first screen.
  -FX
  # Ignore case in searches that do not contain uppercase.
  --ignore-case
  # Allow ANSI colour escapes, but no other escapes.
  --RAW-CONTROL-CHARS
  # Quiet the terminal bell. (when trying to scroll past the end of the buffer)
  --quiet
  # Do not complain when we are on a dumb terminal.
  --dumb
)
export LESS="${less_opts[*]}"

# Default editor for local and remote sessions
if [[ -n "$SSH_CONNECTION" ]]; then
  # on the server
  if [ command -v vim >/dev/null 2>&1 ]; then
    export EDITOR="vim"
  else
    export EDITOR="vi"
  fi
else
  export EDITOR="vim"
fi

# Better formatting for time command
export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# THOR merge tool
export THOR_MERGE="code -d $1 $2"

# QLTY
export QLTY_INSTALL="$HOME/.qlty"

# PostgreSQL
export DYLD_LIBRARY_PATH="/opt/homebrew/opt/postgresql@16/lib"

# Version managers
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && _extend_path "$PYENV_ROOT/bin"
