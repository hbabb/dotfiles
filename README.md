# Dotfiles Repository

## Overview

This repository serves as a centralized archive for my personal configuration files, tailored primarily for an Omarchy setup—an opinionated Arch Linux distribution inspired by DHH principles. As a work-in-progress project, it aims to facilitate seamless configuration management across systems. By leveraging GNU Stow, these dotfiles can be efficiently symlinked into your home directory, enabling quick setups and updates while preserving version control through Git.

Think of this as my digital toolkit: essential configs for productivity, wrapped in a structure that's easy to adopt or adapt. 🚀

## Structure

The repository is organized by application or tool, with each directory containing relevant configuration files. Here's a high-level overview of the contents:

- **alacritty/**: Configuration for the Alacritty terminal emulator.
- **bash/**: Shell configuration files, including `.bashrc`, `.bash_profile`, and others for Bash environments.
- **ghostty/**: Settings for the Ghostty terminal.
- **git/**: Git-related configurations.
- **hypr/**: Configurations for the Hyprland window manager.
- **kitty/**: Settings for the Kitty terminal emulator.
- **lazygit/**: Configuration for LazyGit, a terminal UI for Git.
- **nvim/**: Neovim setup, including plugins, keymaps, and theme integrations via Lazy.vim.
- **omarchy/**: Custom configurations specific to the Omarchy distribution.
- **tmux/**: Tmux session manager settings.
- **XCompose/**: Custom XCompose key mappings for enhanced input.
- **.gitignore**: Excludes unnecessary files from version control.
- **README.md**: This document.

This modular design ensures that you can selectively install only the components you need.

## Installation and Usage

To integrate these dotfiles into your system, follow these steps. Prerequisites include Git and GNU Stow installed on your machine.

1. **Clone the Repository**:

   ```
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Use Stow to Symlink Configurations**:
   Stow creates symbolic links from the repository to your home directory. For example, to install the Neovim config:

   ```
   stow nvim
   ```

   Repeat for other directories as needed (e.g., `stow bash`, `stow tmux`). To remove a stowed package:

   ```
   stow -D nvim
   ```

3. **Customization**:
   Review and modify files to suit your preferences. For instance, the Neovim setup includes a symbolic link to a theme file (`theme.lua`), which can be adjusted for hot-reloading or alternative themes.

Note: Always back up your existing configurations before stowing to avoid overwrites. This setup is optimized for Arch-based systems like Omarchy, but it may require adaptations for other distributions.

## Work in Progress

This repository is actively evolving. Future enhancements may include additional tool integrations, automated setup scripts, or refined themes. Contributions or suggestions are welcome—feel free to open an issue or pull request if you spot improvements.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details (if applicable; currently, a license is included in the Neovim subdirectory).

For questions or feedback, reach out via GitHub issues. Happy configuring! 📂
