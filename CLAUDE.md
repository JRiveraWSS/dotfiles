# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

See `README.md` for the repo layout, per-tool overview, and manual-symlink install steps.

## Commands

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

- **Theme consistency:** Solarized Dark hex values are hardcoded per config file (no shared source — see [ADR-0001](docs/adr/0001-palette-hex-duplicated-per-config.md)). When changing colors, update all files. Key colors: bg `#073642`, fg `#fdf6e3`, blue `#268bd2`, cyan `#2aa198`, magenta `#d33682`, green `#859900`, yellow `#b58900`, red `#dc322f`, orange `#cb4b16`, base01 (comments/dim) `#586e75`, base0 (foreground) `#839496`. Terminal background is `#002b36` (base03), matching Ghostty's "Builtin Solarized Dark". Neovim (`nvim/init.lua`) is the current exception: colorscheme is `habamax` with a transparent background, not part of the Solarized convention.
- **Font:** Terminess Nerd Font Mono set in Ghostty; other tools inherit from the terminal.
- **PATH:** `zsh/.zshenv` adds `~/.cargo/bin`, `~/.opencode/bin`, `~/.lmstudio/bin`, `~/.bun/bin`. NVM manages Node.js.
