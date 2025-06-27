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

# Safety check: ensure we're not accidentally modifying the dotfiles directory
check_safety() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local dotfiles_dir="$(cd "$script_dir/.." && pwd)"
    
    # Check if HOME is within the dotfiles directory (which would be dangerous)
    if [[ "$HOME" == "$dotfiles_dir"* ]]; then
        error "HOME directory ($HOME) is within dotfiles directory ($dotfiles_dir). This is unsafe."
    fi
    
    # Check if dotfiles directory is within HOME (this is the normal case)
    if [[ "$dotfiles_dir" == "$HOME"* ]]; then
        log "Dotfiles directory is within HOME - this is normal"
    else
        warn "Dotfiles directory ($dotfiles_dir) is not within HOME ($HOME) - this might be unusual"
    fi
    
    log "Safety checks passed - dotfiles directory: $dotfiles_dir"
}

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

    # Check if zsh path is in /etc/shells (required for chsh on macOS)
    if ! grep -q "^$zsh_path$" /etc/shells; then
        log "Adding $zsh_path to /etc/shells..."
        if ! echo "$zsh_path" | sudo tee -a /etc/shells > /dev/null; then
            warn "Failed to add zsh to /etc/shells automatically"
            log "Please run the following command manually:"
            echo "echo '$zsh_path' | sudo tee -a /etc/shells"
            log "Then run this setup script again"
            exit 1
        fi
        success "Added zsh to /etc/shells"
    fi

    if [ "$SHELL" != "$zsh_path" ]; then
        log "Setting Zsh as default shell..."
        if ! chsh -s "$zsh_path"; then
            warn "Failed to set Zsh as default shell automatically"
            log "Please run the following command manually:"
            echo "chsh -s '$zsh_path'"
            log "Then restart your terminal"
            exit 1
        fi
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

        if ! check_command "starship"; then
            brew install starship
        fi
    elif [[ "$OS" == "linux" ]]; then
        if ! check_command "sheldon"; then
            curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
                | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
        fi

        if ! check_command "starship"; then
            curl --proto '=https' -fLsS https://starship.rs/install.sh | sh
        fi

        # Ensure ~/.local/bin is in PATH
        export PATH="$HOME/.local/bin:$PATH"
    fi
}

# Create symlinks
create_symlinks() {
    log "Creating symlinks..."

    # Get the dotfiles directory path
    local dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    log "Dotfiles directory: $dotfiles_dir"

    # Create symlinks for individual files (only if they exist)
    if [[ -f "$dotfiles_dir/.zshrc" ]]; then
        # Remove existing file if it exists
        if [[ -e "$HOME/.zshrc" ]]; then
            rm -f "$HOME/.zshrc"
        fi
        ln -sf "$dotfiles_dir/.zshrc" "$HOME/.zshrc"
        success "Symlinked .zshrc"
    else
        warn ".zshrc not found in dotfiles directory"
    fi

    if [[ -f "$dotfiles_dir/home/.gitconfig" ]]; then
        # Remove existing file if it exists
        if [[ -e "$HOME/.gitconfig" ]]; then
            rm -f "$HOME/.gitconfig"
        fi
        ln -sf "$dotfiles_dir/home/.gitconfig" "$HOME/.gitconfig"
        success "Symlinked .gitconfig"
    else
        warn ".gitconfig not found in dotfiles directory"
    fi

    if [[ -f "$dotfiles_dir/home/.gitignore" ]]; then
        # Remove existing file if it exists
        if [[ -e "$HOME/.gitignore" ]]; then
            rm -f "$HOME/.gitignore"
        fi
        ln -sf "$dotfiles_dir/home/.gitignore" "$HOME/.gitignore"
        success "Symlinked .gitignore"
    else
        warn ".gitignore not found in dotfiles directory"
    fi

    if [[ -f "$dotfiles_dir/home/.vimrc" ]]; then
        # Remove existing file if it exists
        if [[ -e "$HOME/.vimrc" ]]; then
            rm -f "$HOME/.vimrc"
        fi
        ln -sf "$dotfiles_dir/home/.vimrc" "$HOME/.vimrc"
        success "Symlinked .vimrc"
    else
        warn ".vimrc not found in dotfiles directory"
    fi

    # Create symlinks for .config files (check both root and home/.config)
    local config_source=""
    if [[ -d "$dotfiles_dir/.config" ]]; then
        config_source="$dotfiles_dir/.config"
        log "Found .config directory in dotfiles root"
    elif [[ -d "$dotfiles_dir/home/.config" ]]; then
        config_source="$dotfiles_dir/home/.config"
        log "Found .config directory in dotfiles/home"
    fi

    if [[ -n "$config_source" ]]; then
        log "Creating .config symlinks from $config_source..."
        
        # Complete replacement approach: backup existing .config, then recreate it
        if [[ -d "$HOME/.config" ]]; then
            local timestamp=$(date +%Y%m%d_%H%M%S)
            local backup_dir="$HOME/.config_backup_$timestamp"
            log "Backing up existing .config to $backup_dir"
            mv "$HOME/.config" "$backup_dir"
        fi
        
        # Create fresh .config directory
        mkdir -p "$HOME/.config"
        
        # Symlink individual config files/directories
        for item in "$config_source"/*; do
            if [[ -e "$item" ]]; then
                basename=$(basename "$item")
                target="$HOME/.config/$basename"
                
                log "DEBUG: Processing item: $item"
                log "DEBUG: Target: $target"
                
                # Handle different types of configs
                if [[ "$basename" == "starship.toml" ]]; then
                    # Symlink read-only config files
                    ln -sf "$item" "$target"
                    success "Symlinked .config/$basename"
                elif [[ -d "$item" ]]; then
                    # For directories that apps write to, copy the initial config
                    cp -r "$item" "$target"
                    success "Copied .config/$basename (writable directory)"
                else
                    # For other files, symlink them
                    ln -sf "$item" "$target"
                    success "Symlinked .config/$basename"
                fi
            fi
        done
    else
        log "No .config directory found in dotfiles"
    fi

    # Create symlinks for zsh configuration files
    if [[ -d "$dotfiles_dir/zsh" ]]; then
        log "Creating zsh configuration symlinks..."
        
        # Create .oh-my-zsh/custom directory if it doesn't exist
        mkdir -p "$HOME/.oh-my-zsh/custom"
        
        # Symlink zsh files to .oh-my-zsh/custom
        for item in "$dotfiles_dir/zsh"/*; do
            if [[ -e "$item" ]]; then
                basename=$(basename "$item")
                target="$HOME/.oh-my-zsh/custom/$basename"
                
                # Create symlink (ln -sf will overwrite existing files)
                ln -sf "$item" "$target"
                success "Symlinked zsh/$basename to .oh-my-zsh/custom/"
            fi
        done
    else
        log "No zsh directory found in dotfiles"
    fi

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
    # Ensure .config directory exists
    mkdir -p "$HOME/.config"
    
    # Sheldon config should be managed by symlinks from dotfiles
    # If plugins.toml doesn't exist after symlink creation, warn the user
    if [[ ! -f "$HOME/.config/sheldon/plugins.toml" ]]; then
        warn "No sheldon plugins.toml found after symlink creation"
        log "If you need a fresh sheldon config, run: sheldon init --shell zsh"
    else
        log "Sheldon configuration found"
    fi

    # Update Sheldon plugins (only if plugins.toml exists)
    if [[ -f "$HOME/.config/sheldon/plugins.toml" ]]; then
        log "Updating Sheldon plugins..."
        if sheldon lock; then
            success "Updated Sheldon plugins"
        else
            warn "Failed to update Sheldon plugins"
        fi
    else
        warn "No plugins.toml found, skipping plugin update"
    fi

    # Verify plugin installation (only if plugins.toml exists)
    if [[ -f "$HOME/.config/sheldon/plugins.toml" ]]; then
        log "Verifying plugin installation..."
        if sheldon source &> /dev/null; then
            success "Plugin verification complete"
        else
            warn "Failed to verify Sheldon plugins"
        fi
    else
        warn "No plugins.toml found, skipping plugin verification"
    fi
}

# Main installation
main() {
    log "Starting installation for $OS..."

    # Add safety checks at the beginning
    check_safety
    
    # Add shell checks at the beginning
    check_zsh
    set_default_shell

    ensure_directories
    install_dependencies
    create_symlinks
    setup_git
    setup_sheldon

    success "Installation complete!"
    warn "Please restart your terminal or run: exec zsh"
}

# Run main function
main
