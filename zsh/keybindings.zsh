# ------------------------------------------------------------------------------
# Key Bindings
# ------------------------------------------------------------------------------

# Initialize completions
autoload -Uz compinit
compinit

# Enable vi mode
bindkey -v

# History substring search (only if widgets exist)
if (( $+widgets[history-substring-search-up] )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

# Bracketed paste magic configuration
