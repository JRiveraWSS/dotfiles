# dotfiles

Personal Linux development environment configuration, unified around **Solarized Dark** theming and **Vim-style (hjkl)** keybindings.

## Layout

One directory per tool at the repo root:

```
zsh/                # Zsh config (symlinked to ~/.config/zsh)
starship.toml       # Starship prompt
ghostty/            # Ghostty terminal emulator
nvim/               # Neovim config (native vim.pack, no plugin-manager framework)
yazi/               # Yazi file manager config (symlinked to ~/.config/yazi)
opencode/           # OpenCode AI plugin (Bun/Node.js)
codex/              # Codex CLI config (symlinked to ~/.codex/config.toml)
herdr/              # herdr terminal workspace manager config (symlinked to ~/.config/herdr/config.toml)
Xresources          # X11 Xft DPI settings for HiDPI display
corne-zmk-config/   # Git submodule: Corne split keyboard firmware (ZMK)
```

## Installation

No install script. Setup is manual symlinks:

```sh
ln -sf ~/dotfiles/zsh ~/.config/zsh
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/yazi ~/.config/yazi
ln -sf ~/dotfiles/Xresources ~/.Xresources
ln -sf ~/dotfiles/codex/config.toml ~/.codex/config.toml
ln -sf ~/dotfiles/herdr/config.toml ~/.config/herdr/config.toml
```

Yazi plugins (declared in `yazi/package.toml`) aren't vendored in the repo — restore them with `ya pkg install` after symlinking.

**Ubuntu/Debian only:** `apt install bat` names the binary `batcat`. Add a shim so configs can call `bat` directly:

```sh
ln -s /usr/bin/batcat ~/.local/bin/bat
```

**HiDPI (2560×1600 laptop):** fractional 150% scaling is pre-configured in `~/.config/monitors.xml`. Run once after first login:

```sh
gsettings set org.gnome.desktop.interface scaling-factor 1
gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"
xrdb -merge ~/.Xresources
```

Then log out and back in for full effect.

## Components

### Zsh

`zsh/` — plugins: `fast-syntax-highlighting`, `zsh-autosuggestions`, `zsh-history-substring-search`, `zsh-vi-mode`. Vim-mode keybindings, `zoxide`/`fzf`/`fd` for navigation, `eza`/`bat`/`ripgrep` as core-utility replacements. Plugin management is a small self-contained loader in `zsh/plugins.zsh` (clones from GitHub on first use).

### Starship

`starship.toml` — Solarized Dark prompt.

### Ghostty

`ghostty/config` — terminal emulator. Theme: Builtin Solarized Dark. Font: Terminess Nerd Font Mono.

### Neovim

`nvim/init.lua` — single-file config, no distribution (not LazyVim). Uses Neovim's built-in `vim.pack` for plugin management (mini.nvim, fzf-lua, nvim-tree, treesitter, nvim-lspconfig, mason, blink.cmp, LuaSnip). Colorscheme is `habamax` with a transparent background — outside the Solarized theming convention used by the other tools.

### OpenCode

`opencode/` — AI coding agent config (Bun/Node.js). Solarized Dark theme (`opencode/themes/solarized-dark.json`). `opencode/plugins/herdr-agent-state.js` is vendored by herdr's opencode integration and gets overwritten on integration updates — don't hand-edit it; add custom hooks in a sibling file instead. `opencode/skills/` symlinks into the shared `~/.agents/skills/` store (the same skills Claude Code uses via `~/.claude/skills/`) so skill content lives in one place across tools.

### Codex CLI

`codex/config.toml` — symlinked to `~/.codex/config.toml`. Reads `AGENTS.md` (see Agent guidance below) for repo context, same as Claude Code.

### herdr

`herdr/config.toml` — symlinked to `~/.config/herdr/config.toml`. Terminal workspace/pane manager for AI coding agent sessions (replaces zellij in this setup). Solarized theme, system toast delivery, Kitty graphics protocol enabled experimentally so panes can render images (yazi, snacks.image).

### Xresources

`Xresources` — X11 Xft DPI/antialiasing settings for the HiDPI laptop display (see Installation above).

### Corne keyboard firmware

`corne-zmk-config/` is a git submodule — ZMK firmware for a Corne split keyboard, built via GitHub Actions (no local build). See its own `AGENTS.md` for keymap and flashing details.

## Theme consistency

Solarized Dark hex values are hardcoded per config file (no shared source, by design — see [ADR-0001](docs/adr/0001-palette-hex-duplicated-per-config.md)). When changing colors, update all files. Key colors: bg `#073642`, fg `#fdf6e3`, blue `#268bd2`, cyan `#2aa198`, magenta `#d33682`, green `#859900`, yellow `#b58900`, red `#dc322f`, orange `#cb4b16`, base01 (comments/dim) `#586e75`, base0 (foreground) `#839496`. Terminal background is `#002b36` (base03). Neovim is the current exception (see above).

## Agent guidance

See `CLAUDE.md` for how AI coding agents (Claude Code, OpenCode, Codex CLI, etc.) should work in this repo — commit conventions, code style, and the issue-tracker/domain-doc skills. `AGENTS.md` is a symlink to `CLAUDE.md` so every tool reads the same, single source of truth.
