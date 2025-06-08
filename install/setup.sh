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

# Check if running in bash
if [ -z "$BASH_VERSION" ]; then
    error "This script must be run with bash"
fi

# Check if Zsh is installed
check_zsh() {
    if ! command -v zsh &> /dev/null; then
        error "Zsh is not installed. Please install Zsh first."
    fi
}

# Ensure Zsh is the default shell
set_default_shell() {
    local zsh_path=$(which zsh)
    if [ -z "$zsh_path" ]; then
        error "Could not find Zsh installation"
    fi

    if [ "$SHELL" != "$zsh_path" ]; then
        log "Setting Zsh as default shell..."
        chsh -s "$zsh_path" || error "Failed to set Zsh as default shell"
        success "Zsh set as default shell. Please restart your terminal after installation."
    else
        log "Zsh is already the default shell"
    fi
}

# Ensure required directories exist
ensure_directories() {
    local dirs=(
        "$HOME/.config"
        "$HOME/.local/bin"
        "$HOME/.oh-my-zsh/custom/themes"
        "$HOME/.config/sheldon"
    )

    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
            log "Created directory: $dir"
        fi
    done
}

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
    # Install Oh My Zsh if not already installed
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        success "Installed Oh My Zsh"
    fi

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
    local files_to_backup=(
        ".zshrc"
        ".gitconfig"
        ".gitignore"
        ".vimrc"
    )

    # Only create backup if any of the files exist and are not already symlinks
    local needs_backup=false
    for file in "${files_to_backup[@]}"; do
        if [[ -f "$HOME/$file" && ! -L "$HOME/$file" ]]; then
            needs_backup=true
            break
        fi
    done

    if [[ "$needs_backup" == "true" ]]; then
        log "Creating backup directory at $backup_dir"
        mkdir -p "$backup_dir"

        for file in "${files_to_backup[@]}"; do
            if [[ -f "$HOME/$file" && ! -L "$HOME/$file" ]]; then
                mv "$HOME/$file" "$backup_dir/"
                success "Backed up $file"
            fi
        done

        if [[ -d "$HOME/.config" && ! -L "$HOME/.config" ]]; then
            cp -r "$HOME/.config" "$backup_dir/"
            success "Backed up .config directory"
        fi
    else
        log "No existing configs to backup"
    fi
}

# Create symlinks
create_symlinks() {
    log "Creating symlinks..."

    # Ensure source files exist before creating symlinks
    if [[ ! -f "$HOME/.dotfiles/.zshrc" ]]; then
        error "Source .zshrc not found in dotfiles directory"
    fi

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
    else
        log "Git configuration already exists"
    fi
}

# Initialize sheldon
setup_sheldon() {
    if [[ ! -d "$HOME/.config/sheldon" ]]; then
        log "Initializing sheldon..."
        mkdir -p "$HOME/.config/sheldon"
        sheldon init --shell zsh
        success "Initialized sheldon"
    else
        log "Sheldon configuration already exists"
    fi

    # Update Sheldon plugins
    log "Updating Sheldon plugins..."
    sheldon lock
    success "Updated Sheldon plugins"

    # Verify plugin installation
    log "Verifying plugin installation..."
    if ! sheldon source &> /dev/null; then
        error "Failed to verify Sheldon plugins"
    fi
    success "Plugin verification complete"
}

# Main installation
main() {
    log "Starting installation for $OS..."

    # Add shell checks at the beginning
    check_zsh
    set_default_shell

    ensure_directories
    install_dependencies
    backup_configs
    create_symlinks
    setup_git
    setup_sheldon

    success "Installation complete!"
    warn "Please restart your terminal or run: exec zsh"
}

# Run main function
main
