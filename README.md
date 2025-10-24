# dotfiles

Personal Linux development environment configuration files featuring Tokyo Night Storm theme and Vim-style keybindings across all tools.

## Overview

This repository contains configuration files for a complete Linux development setup with:

- **Window Manager**: Qtile (Python-based tiling WM)
- **Terminal**: Ghostty with Tokyo Night Storm theme
- **Shell**: Zsh with Oh My Zsh, syntax highlighting, and autosuggestions
- **Terminal Multiplexer**: Zellij with custom keybindings
- **Editor**: Neovim with LazyVim
- **Prompt**: Starship (Gruvbox Dark theme)
- **Keyboard Layout**: Kanata with Tarmak progression to Colemak-DH

## Theme

**Tokyo Night Storm** is used consistently across:

- Ghostty terminal
- Qtile window manager
- Zellij multiplexer
- Zsh syntax highlighting

**Gruvbox Dark** is used for:

- Starship prompt

## Installation

### Prerequisites

Ensure the following are installed:

- Zsh
- Oh My Zsh
- Neovim (LazyVim)
- Ghostty terminal
- Qtile
- Zellij
- Starship
- Kanata
- Node Version Manager (nvm)

### Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Create symlinks for configuration files:

   ```bash
   # Zsh
   ln -sf ~/dotfiles/.zshrc ~/.zshrc

   # Ghostty
   mkdir -p ~/.config/ghostty
   ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config

   # Qtile
   mkdir -p ~/.config/qtile
   ln -sf ~/dotfiles/qtile/config.py ~/.config/qtile/config.py

   # Zellij
   mkdir -p ~/.config/zellij
   ln -sf ~/dotfiles/zellij/config.kdl ~/.config/zellij/config.kdl

   # Neovim
   mkdir -p ~/.config/nvim
   ln -sf ~/dotfiles/nvim ~/.config/nvim

   # Starship
   ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

   # Kanata
   mkdir -p ~/.config/kanata
   ln -sf ~/dotfiles/kanata/kanata.kbd ~/.config/kanata/kanata.kbd
   ```

3. Install Oh My Zsh plugins:

   ```bash
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   ```

4. Source the new configuration:

   ```bash
   source ~/.zshrc
   ```

## Components

### Ghostty Terminal

**Location**: `ghostty/config`

- Theme: Tokyo Night Storm
- Font: JetBrainsMono Nerd Font Mono (19pt)
- Cursor: Blinking block
- Background blur enabled
- Minimal window decoration

### Zsh

**Location**: `.zshrc`

Features:

- Oh My Zsh framework
- Plugins: git, zsh-syntax-highlighting, zsh-autosuggestions
- Vim mode enabled
- Tokyo Night Storm colors for syntax highlighting
- Auto-starts Zellij on interactive shells
- NVM integration
- Neovim as default editor
- Custom PATH configuration

### Qtile

**Location**: `qtile/config.py`

Features:

- Tokyo Night Storm color scheme
- JetBrainsMono Nerd Font throughout
- Tiling layouts: MonadTall, MonadWide, Max, Floating
- Vim-style navigation (hjkl)
- 9 workspaces with emoji icons
- Status bar with system monitoring (CPU, RAM, Network)
- Auto-start applications: nm-applet, picom, blueman-applet, flameshot

Key bindings:

- `Mod+h/j/k/l`: Focus window
- `Mod+Shift+h/j/k/l`: Move window
- `Mod+Control+h/j/k/l`: Resize window
- `Mod+Return`: Launch terminal (Ghostty)
- `Mod+b`: Launch browser (Chrome)
- `Mod+r`: Launch Rofi
- `Mod+e`: Launch file manager (Thunar)
- `Mod+q`: Kill window
- `Mod+1-9`: Switch workspace

### Zellij

**Location**: `zellij/config.kdl`

Features:

- Tokyo Night Storm theme
- Custom modal keybindings
- Default mode: locked (requires Ctrl+g to activate)
- Vim-style navigation
- Startup tips disabled

Modes:

- `Ctrl+g`: Toggle locked mode
- `p`: Pane mode
- `t`: Tab mode
- `r`: Resize mode
- `m`: Move mode
- `s`: Scroll mode
- `o`: Session mode

### Neovim

**Location**: `nvim/`

Configuration based on LazyVim:

- Word wrap enabled
- System clipboard integration
- Dark background with truecolor support
- Animations disabled
- Custom plugins in `lua/plugins/`

### Starship

**Location**: `starship.toml`

Features:

- Gruvbox Dark color scheme
- Multi-line prompt
- OS icon display
- Username always shown
- Directory with substitutions (Documents, Downloads, etc.)
- Git branch and status
- Language version indicators (Node, Python, Rust, Go, etc.)
- Docker context
- Time display
- Vim mode indicators

### Kanata

**Location**: `kanata/kanata.kbd`

Features:

- Tarmak progressive layout for transitioning from QWERTY to Colemak-DH
- Layers: QWERTY → Tarmak1 → Tarmak2 → Tarmak3 → Tarmak4 → Colemak-DH
- Caps Lock mapped to Escape (tap) / Layer switch (hold)
- Quick layer switching with Caps+number keys

Layer switching:

- Caps+1: Tarmak1
- Caps+2: Tarmak2
- Caps+3: Tarmak3
- Caps+4: Tarmak4
- Caps+5: Colemak-DH
- Caps+0: QWERTY

### GNOME Extensions (if applicable)

**Location**: `extensions.txt`

The extensions file contains settings for various GNOME Shell extensions including blur-my-shell, dash-to-dock, tiling-assistant, and others configured with custom themes and behaviors.

## Keybindings Philosophy

All tools use **Vim-style hjkl navigation** where possible:

- Qtile: hjkl for window navigation
- Zellij: hjkl for pane navigation
- Zsh: Vi mode enabled
- Neovim: Native Vim keybindings

## Customization

### Change Theme

To change from Tokyo Night Storm to another theme:

1. Update Ghostty config with desired theme name
2. Modify Qtile color palette in `config.py`
3. Change Zellij theme in `config.kdl`
4. Update Zsh syntax highlighting colors in `.zshrc`

### Modify Keybindings

- **Qtile**: Edit `keys` list in `qtile/config.py`
- **Zellij**: Modify keybind sections in `zellij/config.kdl`
- **Kanata**: Edit layer definitions in `kanata/kanata.kbd`

## Troubleshooting

### Zellij doesn't auto-start

Set `NO_ZELLIJ=1` environment variable to disable auto-start:

```bash
export NO_ZELLIJ=1
```

### Fonts not rendering correctly

Install JetBrainsMono Nerd Font:

```bash
# Download from https://www.nerdfonts.com/
# Or use your package manager
```

### Kanata not working

Ensure Kanata daemon is running and you have proper permissions for input devices.

## License

MIT License - See LICENSE file

## Credits

- [Tokyo Night](https://github.com/enkia/tokyo-night-vscode-theme) - Color scheme
- [Gruvbox](https://github.com/morhetz/gruvbox) - Starship color scheme
- [LazyVim](https://github.com/LazyVim/LazyVim) - Neovim configuration
- [Oh My Zsh](https://ohmyz.sh/) - Zsh framework
- [Starship](https://starship.rs/) - Shell prompt
- [Tarmak](https://dreymar.colemak.org/tarmak.html) - Progressive keyboard layout learning
