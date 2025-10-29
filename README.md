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
- **Launcher**: Rofi with Tokyo Night Storm theme (grid view, icons)
- **Power Menu**: Rofi-based power menu with Tokyo Night Storm theme
- **Lock Screen**: i3lock-color with live clock and blurred wallpaper

## Theme

**Tokyo Night Storm** is used consistently across:

- Ghostty terminal
- Qtile window manager
- Rofi launcher and menus
- i3lock-color lock screen
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

   # Rofi
   mkdir -p ~/.config/rofi
   ln -sf ~/dotfiles/rofi ~/.config/rofi

   # Scripts
   mkdir -p ~/bin
   ln -sf ~/dotfiles/scripts/powermenu.sh ~/bin/powermenu.sh
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
- `Mod+s`: Launch Slack
- `Mod+l`: Lock screen (blurred wallpaper)
- `Mod+Shift+e`: Power menu
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

### Rofi

**Location**: `rofi/`

Modern application launcher and menu system with Tokyo Night Storm theme.

Features:

- **Grid Layout**: 5x4 grid displaying 20 apps at once
- **Application Icons**: Large 64px icons with app names
- **Search Bar**: Fast fuzzy search with placeholder text
- **Multiple Modes**:
  - `drun`: Application launcher (default)
  - `run`: Command runner
  - `window`: Window switcher
  - `filebrowser`: File browser
- **Styling**:
  - Rounded corners (16px border radius)
  - Transparency with blur support
  - Color-coded selection (cyan highlight)
  - Smooth hover states
- **Alphabetical Sorting**: Apps sorted alphabetically for easy finding
- **Icon Theme**: Papirus-Dark icon set

Usage:

- `Mod+r`: Open application launcher
- Type to search, arrow keys to navigate, Enter to launch
- Esc to cancel

Configuration:

- Main config: `rofi/config.rasi`
- Theme: `rofi/tokyo-night-storm.rasi`
- Customize: grid size (columns/lines), icon size, colors, fonts

### Lock Screen

**Location**: `scripts/lock.sh`

Custom i3lock-color screen locker with blurred wallpaper and live clock display.

Features:

- **Live Updating Clock**: Displays current time in 12-hour format with AM/PM (e.g., 02:30:45 PM)
- **Date Display**: Shows full day and date (e.g., "Wednesday, October 29")
- **Blurred Wallpaper**: Scales wallpaper to full screen (2560x1600) with medium blur effect
- **Tokyo Night Storm Colors**: 
  - Cyan blue clock and unlock ring (#7aa2f7)
  - Dark background with transparency (#1a1b26)
  - Red highlight for wrong password (#f7768e)
- **Centered Indicator**: 120px radius circle with 8px ring width
- **Custom Fonts**: JetBrainsMono Nerd Font (72px time, 24px date)

Usage:

- `Mod+l`: Quick lock screen
- Power menu → Lock option
- Or run directly: `~/dotfiles/scripts/lock.sh`

Requirements:

- **i3lock-color**: Enhanced screen locker with clock/color support
- **ImageMagick**: For blur and wallpaper scaling (`convert` command)

Install dependencies:

```bash
# Ubuntu/Debian - Build i3lock-color from source
sudo apt install -y autoconf gcc make pkg-config libpam0g-dev libcairo2-dev \
  libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev \
  libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev \
  libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev

cd /tmp
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh

# Also install ImageMagick
sudo apt install imagemagick

# Arch
yay -S i3lock-color imagemagick

# Fedora
sudo dnf copr enable admiralnemo/i3lock-color
sudo dnf install i3lock-color ImageMagick
```

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

### Power Menu

**Location**: `scripts/powermenu.sh`

Features:

- Tokyo Night Storm themed rofi interface
- Options: Lock, Logout, Reboot, Shutdown, Suspend
- Confirmation prompts for destructive actions (reboot/shutdown)
- JetBrainsMono Nerd Font icons
- Integration with systemctl for power management

Usage:

- `Mod+Shift+e`: Open power menu
- Or run directly: `~/dotfiles/scripts/powermenu.sh`

The power menu integrates with the custom lock screen script (`scripts/lock.sh`) which uses i3lock-color. See the Lock Screen section for installation details.

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
