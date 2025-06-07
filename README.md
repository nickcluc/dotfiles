# Cross-Platform Dotfiles

A clean, organized collection of shell configurations and dotfiles that work across macOS and Linux.

## Prerequisites

- Git
- Zsh
- [Sheldon](https://sheldon.cli.rs/) - Plugin manager for shell
- Terminal-notifier (macOS only, will be installed automatically if needed)

## Quick Install

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/.dotfiles.git ~/.dotfiles

# Run the install script
cd ~/.dotfiles && ./install/setup.sh
```

## Manual Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/YOUR_USERNAME/.dotfiles.git ~/.dotfiles
   ```

2. Install Sheldon (if not already installed):

   - On macOS: `brew install sheldon`
   - On Linux:
     ```bash
     curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
       | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
     ```

3. Create symlinks:

   ```bash
   ln -sf ~/.dotfiles/.zshrc ~/.zshrc
   ln -sf ~/.dotfiles/home/.config ~/.config
   ln -sf ~/.dotfiles/home/.gitconfig ~/.gitconfig
   ln -sf ~/.dotfiles/home/.gitignore ~/.gitignore
   ln -sf ~/.dotfiles/home/.vimrc ~/.vimrc
   ```

4. Restart your shell:
   ```bash
   exec zsh
   ```

## Structure

```
.dotfiles/
├── zsh/                    # ZSH-specific configurations
│   ├── aliases.zsh         # Command aliases
│   ├── completions.zsh     # Tool completions
│   ├── exports.zsh         # Environment variables
│   ├── functions.zsh       # Utility functions
│   ├── keybindings.zsh     # Key bindings
│   ├── spaceship.zsh       # Spaceship prompt config
│   └── local.zsh          # Local/sensitive configs
├── config/                 # Application configurations
│   ├── git/               # Git configurations
│   ├── vim/               # Vim configurations
│   └── etc/               # Other tool configurations
├── home/                  # Home directory dotfiles
├── install/               # Installation scripts
└── .zshrc                 # Main ZSH configuration
```

## Platform-Specific Features

- On macOS:

  - Terminal notifications via terminal-notifier
  - macOS-specific aliases and functions
  - Homebrew integration

- On Linux:
  - Uses native system notifications
  - Linux-specific aliases and functions
  - Package manager agnostic

## Customization

- **Local Settings**: Create `~/.zshlocal` for machine-specific settings (not version controlled)
- **Git Settings**: Edit `home/.gitconfig` for user-specific git configuration
- **Aliases**: Add to `zsh/aliases.zsh`
- **Functions**: Add to `zsh/functions.zsh`
- **Environment**: Edit `zsh/exports.zsh`

## Updating

To update your dotfiles:

```bash
cd ~/.dotfiles
git pull
./install/setup.sh
```

## Contributing

Feel free to fork and submit pull requests for improvements!
