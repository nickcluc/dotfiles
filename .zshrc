# Ensure we're running in Zsh mode
if [ -n "$BASH_VERSION" ]; then
    exec /home/linuxbrew/.linuxbrew/bin/zsh "$0" "$@"
fi

# Load required ZSH modules first
autoload -Uz colors

# Set DOTFILES path first, before anything else
export DOTFILES="$HOME/.dotfiles"

# Detect OS type
case "$(uname)" in
  Darwin)
    export OS_TYPE="macos"
    ;;
  Linux)
    export OS_TYPE="linux"
    ;;
  *)
    export OS_TYPE="unknown"
    ;;
esac

# Fig pre block. Keep at the top of this file.
if [[ "$OS_TYPE" == "macos" && -f "$HOME/.fig/shell/zshrc.pre.zsh" ]]; then
  builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
elif [[ "$OS_TYPE" == "linux" && -f "$HOME/.fig/shell/zshrc.pre.zsh" ]]; then
  builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
fi

# ------------------------------------------------------------------------------
# New Organized ZSH Configuration
# ------------------------------------------------------------------------------

# Do not override files using `>`, but it's still possible using `>!`
set -o noclobber

# ------------------------------------------------------------------------------
# ZSH Configuration
# ------------------------------------------------------------------------------

# Load colors
colors

# Bracketed paste magic configuration
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

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
# Oh My Zsh & Plugins (Sheldon)
# ------------------------------------------------------------------------------

ZSH_DISABLE_COMPFIX=true

# Shell plugins (managed by Sheldon)
eval "$(sheldon source)"

# ------------------------------------------------------------------------------
# Load Organized Configuration Modules
# ------------------------------------------------------------------------------

# Load all zsh configuration files
if [[ -d "$DOTFILES/zsh" ]]; then
    for config_file in "$DOTFILES"/zsh/*.zsh; do
        if [[ -r "$config_file" ]]; then
            source "$config_file"
        fi
    done
fi

# ------------------------------------------------------------------------------
# Tool Configuration
# ------------------------------------------------------------------------------

# Cursor configuration (fix sandbox issues on Linux)
if [[ "$OS_TYPE" == "linux" ]]; then
  alias cursor="cursor --no-sandbox"
fi

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

# Homebrew completions (macOS and Linux)
if [[ "$OS_TYPE" == "macos" ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
else
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

# Cursor completions
if [[ "$OS_TYPE" == "macos" ]]; then
  [ -s "/opt/homebrew/share/zsh/site-functions/_qlty" ] && source "/opt/homebrew/share/zsh/site-functions/_qlty"
elif [[ "$OS_TYPE" == "linux" ]]; then
  [ -s "/home/linuxbrew/.linuxbrew/share/zsh/site-functions/_qlty" ] && source "/home/linuxbrew/.linuxbrew/share/zsh/site-functions/_qlty"
fi

# Fig post block. Keep at the bottom of this file.
if [[ "$OS_TYPE" == "macos" && -f "$HOME/.fig/shell/zshrc.post.zsh" ]]; then
  builtin source "$HOME/.fig/shell/zshrc.post.zsh"
elif [[ "$OS_TYPE" == "linux" && -f "$HOME/.fig/shell/zshrc.post.zsh" ]]; then
  builtin source "$HOME/.fig/shell/zshrc.post.zsh"
fi
