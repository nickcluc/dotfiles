#!/bin/bash

set -e

# Colors for output
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

# Helper functions
log() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Detect OS
if [[ "$(uname)" == "Darwin" ]]; then
    OS="macos"
elif [[ "$(uname)" == "Linux" ]]; then
    OS="linux"
else
    error "Unsupported operating system"
fi

# Check for required commands
check_command() {
    if ! command -v "$1" &> /dev/null; then
        warn "$1 not found. Installing..."
        return 1
    fi
    return 0
}

# Install dependencies based on OS
install_dependencies() {
    if [[ "$OS" == "macos" ]]; then
        if ! check_command "brew"; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

        if ! check_command "terminal-notifier"; then
            brew install terminal-notifier
        fi

        if ! check_command "sheldon"; then
            brew install sheldon
        fi
    elif [[ "$OS" == "linux" ]]; then
        if ! check_command "sheldon"; then
            curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
                | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
        fi

        # Ensure ~/.local/bin is in PATH
        export PATH="$HOME/.local/bin:$PATH"
    fi
}

# Backup existing configs
backup_configs() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="$HOME/.dotfiles_backup_$timestamp"

    log "Creating backup directory at $backup_dir"
    mkdir -p "$backup_dir"

    for file in .zshrc .gitconfig .gitignore .vimrc; do
        if [[ -f "$HOME/$file" ]]; then
            mv "$HOME/$file" "$backup_dir/"
            success "Backed up $file"
        fi
    done

    if [[ -d "$HOME/.config" ]]; then
        cp -r "$HOME/.config" "$backup_dir/"
        success "Backed up .config directory"
    fi
}

# Create symlinks
create_symlinks() {
    log "Creating symlinks..."

    ln -sf "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
    ln -sf "$HOME/.dotfiles/home/.config" "$HOME/.config"
    ln -sf "$HOME/.dotfiles/home/.gitconfig" "$HOME/.gitconfig"
    ln -sf "$HOME/.dotfiles/home/.gitignore" "$HOME/.gitignore"
    ln -sf "$HOME/.dotfiles/home/.vimrc" "$HOME/.vimrc"

    success "Created symlinks"
}

# Setup git configuration
setup_git() {
    if [[ ! -f "$HOME/.gitconfig.local" ]]; then
        log "Setting up git configuration..."

        read -p "Enter your git username: " git_name
        read -p "Enter your git email: " git_email

        cat > "$HOME/.gitconfig.local" << EOF
[user]
    name = $git_name
    email = $git_email
EOF
        success "Created git configuration"
    fi
}

# Main installation
main() {
    log "Starting installation for $OS..."

    install_dependencies
    backup_configs
    create_symlinks
    setup_git

    # Initialize sheldon
    if [[ ! -d "$HOME/.config/sheldon" ]]; then
        mkdir -p "$HOME/.config/sheldon"
        sheldon init --shell zsh
    fi

    success "Installation complete!"
    warn "Please restart your shell or run: exec zsh"
}

# Run main installation
main
