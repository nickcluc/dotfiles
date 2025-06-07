# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# ------------------------------------------------------------------------------
# New Organized ZSH Configuration
# ------------------------------------------------------------------------------

# Export path to root of dotfiles repo
export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}

# Do not override files using `>`, but it's still possible using `>!`
set -o noclobber

# ------------------------------------------------------------------------------
# ZSH Configuration
# ------------------------------------------------------------------------------

# Load completions
autoload -U compinit
compinit -i

# Load colors
autoload -U colors
colors

# Basic zsh settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY             # Share history between sessions
setopt EXTENDED_HISTORY          # Add timestamps to history
setopt APPEND_HISTORY           # Adds history
setopt INC_APPEND_HISTORY       # Add commands as they are typed
setopt HIST_IGNORE_ALL_DUPS     # Don't record duplicates
setopt HIST_REDUCE_BLANKS       # Remove blank lines
setopt AUTO_CD                  # cd by typing directory name
setopt CORRECT                  # Auto correct mistakes
setopt EXTENDED_GLOB            # Extended globbing

# ------------------------------------------------------------------------------
# Load Organized Configuration Modules
# ------------------------------------------------------------------------------

# Load all zsh configuration files
for config_file in "$DOTFILES"/zsh/*.zsh; do
  [ -r "$config_file" ] && source "$config_file"
done

# ------------------------------------------------------------------------------
# Oh My Zsh Configuration
# ------------------------------------------------------------------------------

ZSH_DISABLE_COMPFIX=true

# OMZ is managed by Sheldon
export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

# Shell plugins (managed by Sheldon)
eval "$(sheldon source)"

# ------------------------------------------------------------------------------
# Tool Configuration
# ------------------------------------------------------------------------------

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Pyenv configuration
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Rbenv configuration
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# ------------------------------------------------------------------------------
# Local Configuration Override
# ------------------------------------------------------------------------------

# Source local configuration (for sensitive/machine-specific settings)
if [[ -f "$HOME/.zshlocal" ]]; then
  source "$HOME/.zshlocal"
fi

# ------------------------------------------------------------------------------

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

# qlty completions
[ -s "/opt/homebrew/share/zsh/site-functions/_qlty" ] && source "/opt/homebrew/share/zsh/site-functions/_qlty"
