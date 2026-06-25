# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Linux development environment dotfiles unified around **Solarized Dark** theming and **Vim-style (hjkl)** keybindings. One directory per tool at the repo root:

```
.zshrc              # Zsh config (lives at repo root, symlinked to ~/.zshrc)
starship.toml       # Starship prompt
ghostty/            # Ghostty terminal emulator
nvim/               # Neovim (LazyVim, symlinked to ~/.config/nvim)
opencode/           # OpenCode AI plugin (Bun/Node.js)
Xresources          # X11 Xft DPI settings for HiDPI display
```

## Installation

No install script. Setup is manual symlinks:

```sh
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/Xresources ~/.Xresources
```

**HiDPI (2560×1600 laptop):** Fractional 150% scaling is pre-configured in `~/.config/monitors.xml`. Run once after first login:

```sh
gsettings set org.gnome.desktop.interface scaling-factor 1
gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"
xrdb -merge ~/.Xresources
```

Then log out and back in for full effect.

## Commands

### Shell scripts

```sh
shellcheck scripts/*.sh
```

### OpenCode plugin

```sh
cd opencode && bun install
```

## Code Style

### Bash / Shell (`.zshrc`)
- Shebang: `#!/usr/bin/env bash`
- `UPPER_SNAKE_CASE` for all variables
- Double quotes around all variable expansions
- `[[ ... ]]` double-bracket conditionals

### Config file formats
- **Ghostty**: `key = value` pairs
- **Starship**: TOML

## Commit Conventions

Conventional Commits format:
```
type(scope): imperative description
```
- **Types:** `feat`, `fix`, `chore`
- **Scopes:** tool/directory name (e.g., `nvim`, `ghostty`, `dotfiles`)

## Agent skills

### Issue tracker

Issues are tracked as entries in a `todo.txt` file at the repo root, managed via the tuxedo CLI. See `docs/agents/issue-tracker.md`.

### Triage labels

Todo.txt `@context` tags are used for the five canonical triage roles. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context (repo root). See `docs/agents/domain.md`.

## Project Notes

- **Theme consistency:** Solarized Dark hex values are hardcoded per config file (no shared source). When changing colors, update all files. Key colors: bg `#073642`, fg `#fdf6e3`, blue `#268bd2`, cyan `#2aa198`, magenta `#d33682`, green `#859900`, yellow `#b58900`, red `#dc322f`, orange `#cb4b16`, base01 (comments/dim) `#586e75`, base0 (foreground) `#839496`. Neovim uses the `maxmx03/solarized.nvim` plugin configured in `nvim/lua/plugins/colorscheme.lua`; terminal background is `#002b36` (base03), matching Ghostty's "Builtin Solarized Dark".
- **Font:** Terminess Nerd Font Mono set in Ghostty; other tools inherit from the terminal.
- **PATH:** `.zshrc` adds `~/.cargo/bin`, `~/.lmstudio/bin`, `~/.dotnet/tools`, `~/.opencode/bin`. NVM manages Node.js.
