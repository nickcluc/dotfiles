# ------------------------------------------------------------------------------
# Tool Completions & Initializers
# ------------------------------------------------------------------------------

# Version managers
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if command -v nodenv >/dev/null 2>&1; then
  eval "$(nodenv init -)"
fi

# Per-directory configs
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# TheFuck
if command -v thefuck >/dev/null 2>&1; then
  eval $(thefuck --alias)
fi

# bun completions
if [ -s "$HOME/.bun/_bun" ]; then
  source "$HOME/.bun/_bun"
fi

# Docker CLI completions
if [ -d "$HOME/.docker/completions" ]; then
  fpath=($HOME/.docker/completions $fpath)
fi

# QLTY completions
if [ -s "/opt/homebrew/share/zsh/site-functions/_qlty" ]; then
  source "/opt/homebrew/share/zsh/site-functions/_qlty"
fi

# Initialize completions
autoload -Uz compinit
compinit
