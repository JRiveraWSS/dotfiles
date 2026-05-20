# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Linux development environment dotfiles unified around **Solarized Dark** theming and **Vim-style (hjkl)** keybindings. One directory per tool at the repo root:

```
.zshrc              # Zsh config (lives at repo root, symlinked to ~/.zshrc)
starship.toml       # Starship prompt
ghostty/            # Ghostty terminal emulator
nvim/               # Neovim (no custom config, built-in defaults)
opencode/           # OpenCode AI plugin (Bun/Node.js)
zellij/             # Zellij terminal multiplexer
```

## Installation

No install script. Setup is manual symlinks:

```sh
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
ln -sf ~/dotfiles/zellij/config.kdl ~/.config/zellij/config.kdl
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
```

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
- **Zellij**: KDL format with `//` line comments
- **Starship**: TOML

## Commit Conventions

Conventional Commits format:
```
type(scope): imperative description
```
- **Types:** `feat`, `fix`, `chore`
- **Scopes:** tool/directory name (e.g., `nvim`, `ghostty`, `zellij`, `dotfiles`)

## Project Notes

- **Theme consistency:** Solarized Dark hex values are hardcoded per config file (no shared source). When changing colors, update all files. Key colors: bg `#073642`, fg `#fdf6e3`, blue `#268bd2`, cyan `#2aa198`, magenta `#d33682`, green `#859900`, yellow `#b58900`, red `#dc322f`, orange `#cb4b16`, base01 (comments/dim) `#586e75`, base0 (foreground) `#839496`. Neovim uses a custom colorscheme at `nvim/colors/solarizeddark.lua` (applied via `vim.cmd('colorscheme solarizeddark')` in `plugin/30_mini.lua`).
- **Font:** Terminess Nerd Font Mono set in Ghostty; other tools inherit from the terminal.
- **Zellij auto-start:** Zellij starts automatically on interactive shells. Disable with `export NO_ZELLIJ=1`.
- **PATH:** `.zshrc` adds `~/.cargo/bin`, `~/.lmstudio/bin`, `~/.dotnet/tools`, `~/.opencode/bin`. NVM manages Node.js.
