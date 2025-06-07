# ------------------------------------------------------------------------------
# Key Bindings
# ------------------------------------------------------------------------------

# zsh-history-substring-search
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Bracketed paste magic configuration
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
