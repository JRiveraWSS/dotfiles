# AGENTS.md

## Overview

Personal Linux dotfiles repository for a complete desktop development environment.
Configs are unified around **Tokyo Night Storm** theming and **Vim-style (hjkl)** keybindings.

**Languages:** Lua (Neovim), Python (Qtile), Bash (scripts), Zsh (shell), KDL (Zellij),
TOML (Starship, StyLua), Rasi (Rofi), Kanata KBD, Devicetree/YAML (ZMK keyboard firmware).

**Directory layout** -- one directory per tool at the repo root:
```
.zshrc              # Zsh shell config (lives at repo root)
starship.toml       # Starship prompt config
ghostty/            # Ghostty terminal emulator
kanata/             # Kanata keyboard remapper (Colemak-DH)
nvim/               # Neovim (LazyVim framework, 59 plugins)
opencode/           # OpenCode AI plugin (Bun/Node.js)
picom/              # Picom compositor
qtile/              # Qtile tiling window manager
rofi/               # Rofi launcher + theme
scripts/            # Shell scripts (lock screen, power menu)
zellij/             # Zellij terminal multiplexer
corne-wireless-config/  # ZMK firmware for Corne keyboard (SEPARATE git repo)
```

## Build / Lint / Test Commands

There is **no traditional build system**, Makefile, or test framework in this repository.

### Lua (Neovim config)

Format check (dry run):
```sh
stylua --check nvim/
```
Auto-format:
```sh
stylua nvim/
```
Configuration: `nvim/stylua.toml` (2-space indent, 120 column width).

Neovim plugin management (run inside Neovim):
- `:Lazy sync` -- install/update all plugins
- `:Lazy health` -- check plugin health
- Plugin versions are pinned in `nvim/lazy-lock.json`.

### Shell scripts

No shellcheck config exists, but scripts should pass:
```sh
shellcheck scripts/*.sh
```

### OpenCode plugin

```sh
cd opencode && bun install
```

### ZMK keyboard firmware

The `corne-wireless-config/` directory is a **separate git repository** with its own
GitHub Actions CI (`.github/workflows/build.yml`). Firmware builds are triggered
automatically on push/PR to that repo. Do not commit changes to it from this repo.

### Running a single test

No test framework exists. There are no test files in this repository.

## Installation

Setup is entirely manual symlinks, documented in `README.md`. The pattern is:
```sh
ln -sf ~/dotfiles/<tool-dir> ~/.config/<tool>
# Example:
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/.zshrc ~/.zshrc
```
There is no install script or bootstrap automation.

## Code Style Guidelines

### Lua (Neovim -- `nvim/lua/`)

- **Formatter:** StyLua (`nvim/stylua.toml`)
- **Indentation:** 2 spaces
- **Column width:** 120
- **Strings:** Double quotes (`"string"`)
- **Naming:** `snake_case` for local variables (`local lazypath`, `local has_words_before`)
- **Trailing commas:** Always include in tables
- **Comments:** `--` single-line; `---@param` for LuaDoc annotations
- **Plugin file pattern:** One file per plugin in `nvim/lua/plugins/`. Each file returns
  a table or list of tables:
  ```lua
  -- Simple plugin (declarative):
  return { "author/plugin-name", opts = { ... } }

  -- Complex plugin (config function):
  return {
    "author/plugin-name",
    config = function()
      require("plugin").setup({ ... })
    end,
  }
  ```
- **Vim API:** Use `vim.opt.*`, `vim.g.*`, `vim.fn.*`, `vim.api.*` directly
- **Framework:** LazyVim -- follow its conventions for `lua/config/` and `lua/plugins/`

### Python (Qtile -- `qtile/config.py`)

- **Strings:** Double quotes
- **Naming:** `snake_case` for all identifiers (variables, functions, constants)
- **Imports:** Use `from X import Y` style; standard library first, then third-party
- **Type hints:** Minimal (only used where required by Qtile)
- **Section headers:** Use divider comments:
  ```python
  # --------------------------------------------------------------
  # Section Name
  # --------------------------------------------------------------
  ```
- **Config sharing:** Use `**dict_unpacking` for shared options (e.g., `layout.MonadTall(**layout_theme)`)
- **f-strings:** Preferred for string interpolation
- **Error handling:** Bare `except Exception: pass` is used in hooks (not ideal, but existing pattern)

### Bash / Shell (`scripts/`, `.zshrc`)

- **Shebang:** `#!/usr/bin/env bash`
- **Variable naming:** `UPPER_SNAKE_CASE` for all variables
- **Quoting:** Double quotes around all variable expansions; `${VAR}` when embedded
  in strings, `$VAR` in standalone positions
- **Arrays:** Bash arrays with `"${ARRAY[@]}"` expansion for complex argument lists
- **Conditionals:** `[[ ... ]]` double-bracket syntax
- **String building:** `printf` with `\n` separators, piped to commands
- **Line continuation:** Backslash `\` at end of line for long commands
- **Error handling:** None currently (`set -e` / `set -o pipefail` are not used)
- **Functions:** Not used in existing scripts (linear/sequential flow)
- **Comments:** `#` with a space; brief description at top of file; inline comments
  to label sections

### Configuration Files

Each tool uses its native config format. Follow existing patterns:
- **Ghostty:** `key = value` pairs
- **Picom:** C-like config with `# ------` section dividers (matches Python style)
- **Rofi:** Rasi (CSS-like) with `/* ... */` decorative block comment headers
- **Zellij:** KDL format with `//` line comments
- **Kanata:** S-expression syntax with `;;` comments
- **Starship:** TOML

## Commit Conventions

Use **Conventional Commits** format:
```
type(scope): imperative description
```
- **Types:** `feat`, `fix`, `chore`
- **Scopes:** Tool/directory name (e.g., `lock`, `qtile`, `rofi`, `nvim`, `dotfiles`)
- **Message style:** Imperative mood, lowercase after the colon
- **Examples:**
  - `feat(nvim): add codecompanion plugin for AI assistance`
  - `fix(scripts): correct wallpaper path in lock script`
  - `chore(dotfiles): update configs and plugins`

## Project Notes

- **Nested git repo:** `corne-wireless-config/` is a separate git repository. Do not
  stage or commit its files from the parent dotfiles repo.
- **Theme consistency:** Tokyo Night Storm hex values are hardcoded per config file
  (no shared color source). When changing colors, update all files that reference them.
  Key colors: bg `#24283b`, fg `#c0caf5`, blue `#7aa2f7`, cyan `#7dcfff`,
  magenta `#bb9af7`, green `#9ece6a`, yellow `#e0af68`, red `#f7768e`.
- **Font:** JetBrainsMono Nerd Font is used across all tools.
- **No AI rule files:** No `.cursorrules`, `.github/copilot-instructions.md`, or
  similar files exist. This AGENTS.md is the sole source of agent instructions.
- **PATH dependencies:** `.zshrc` adds `~/.cargo/bin`, `~/.lmstudio/bin`, and
  `~/.dotnet/tools` to PATH. NVM manages Node.js versions.
