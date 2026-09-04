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
qutebrowser/        # qutebrowser config (symlinked to ~/.config/qutebrowser/config.py)
opencode/           # OpenCode AI plugin (Bun/Node.js)
codex/              # Codex CLI config (symlinked to ~/.codex/config.toml)
Xresources          # X11 Xft DPI settings for HiDPI display
corne-zmk-config/   # Git submodule: Corne split keyboard firmware (ZMK)
```

## Installation

One command, idempotent (safe to re-run):

```sh
./install.sh            # link configs, check prereqs, apply one-off fixes
./install.sh --check    # dry run: show what would change without touching anything
```

`install.sh` links the config dirs/files below (`--skip-hidpi` skips the gnome scaling block). Manual fallback:

```sh
ln -sf ~/dotfiles/zsh ~/.config/zsh
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/yazi ~/.config/yazi
ln -sf ~/dotfiles/qutebrowser/config.py ~/.config/qutebrowser/config.py
ln -sf ~/dotfiles/opencode ~/.config/opencode
ln -sf ~/dotfiles/Xresources ~/.Xresources
ln -sf ~/dotfiles/codex/config.toml ~/.codex/config.toml
```

The zsh plugins (`zsh/plugins/*`) and yazi plugins (`yazi/plugins/`) aren't vendored in the repo. Restore yazi plugins with `ya pkg install`; the zsh plugin loader (`zsh/plugins.zsh`) clones its own on first shell start. `corne-zmk-config` is a real submodule (`git submodule update --init` if missing).

**qutebrowser:** Ubuntu 24.04's apt package is pinned at 2.5.4 (QtWebEngine 5.15 / **Chromium 87**, from 2020 — years of unpatched engine CVEs). Install a current build into an isolated env instead; `~/.local/bin` already precedes `/usr/bin` on `PATH`, so this shadows the apt binary:

```sh
uv tool install qutebrowser --with PyQt6 --with PyQt6-WebEngine --with adblock
```

GUI launchers read `.desktop` files, which resolve `qutebrowser` against the *session* PATH and can still find the apt binary. Pin it with a user-level override:

```sh
sed 's|^Exec=qutebrowser|Exec='"$HOME"'/.local/bin/qutebrowser|' \
  /usr/share/applications/org.qutebrowser.qutebrowser.desktop \
  > ~/.local/share/applications/org.qutebrowser.qutebrowser.desktop
```

Then run `:adblock-update` once inside qutebrowser to fetch the filter lists.

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

`nvim/init.lua` — thin loader for the config modules in `nvim/lua/config/` (options, keymaps, autocmds, theme, statusline, treesitter, plugins, lsp, terminal). No distribution (not LazyVim), uses Neovim's built-in `vim.pack` for plugin management (mini.nvim, fzf-lua, yazi, treesitter, nvim-lspconfig, mason, efm, blink.cmp, LuaSnip). Colorscheme is `solarized` via `maxmx03/solarized.nvim` with a transparent background so the terminal's Solarized Dark shows through.

### qutebrowser

`qutebrowser/config.py` — keyboard-driven browser, Solarized Dark, symlinked to `~/.config/qutebrowser/config.py`. `config.load_autoconfig(False)` makes this file the sole source of truth, so `:set` changes made at runtime are deliberately not persisted — edit the file and `:config-source` (bound to `,c`).

Stock qutebrowser keybindings are left intact so motions match `nvim/init.lua`, which also keeps vim's default `hjkl`/`n`/`K` despite Colemak DH typing. The one Colemak DH concession is `hints.chars = "arstneio"` — the letters the Colemak DH home row actually emits, replacing the QWERTY-home-row default `asdfghjkl`. Hints are labels you read rather than motions, so this costs no muscle memory. A commented-out full Colemak DH navigation block sits at the bottom of the config if that ever changes.

Additive bindings live on the free `,` prefix: `,c` reload config, `,C` edit config, `,d` toggle forced dark mode, `,b` toggle ad blocking, `,m` play the current page in mpv, `;m` play a hinted link in mpv, `xb`/`xt` toggle status/tab bars.

`Ctrl-E` in insert mode opens the focused text field in Neovim (via a spawned Ghostty window) and writes it back on save.

### OpenCode

`opencode/` — AI coding agent config (Bun/Node.js). Solarized Dark theme (`opencode/themes/solarized-dark.json`). `opencode/skills/` symlinks into the shared `~/.agents/skills/` store (the same skills Claude Code uses via `~/.claude/skills/`) so skill content lives in one place across tools.

### Codex CLI

`codex/config.toml` — symlinked to `~/.codex/config.toml`. Reads `AGENTS.md` (see Agent guidance below) for repo context, same as Claude Code.

### Xresources

`Xresources` — X11 Xft DPI/antialiasing settings for the HiDPI laptop display (see Installation above).

### Corne keyboard firmware

`corne-zmk-config/` is a git submodule — ZMK firmware for a Corne split keyboard, built via GitHub Actions (no local build). See its own `AGENTS.md` for keymap and flashing details.

## Theme consistency

Solarized Dark hex values are hardcoded per config file (no shared source, by design — see [ADR-0001](docs/adr/0001-palette-hex-duplicated-per-config.md)). When changing colors, update all files. Key colors: bg `#073642`, fg `#fdf6e3`, blue `#268bd2`, cyan `#2aa198`, magenta `#d33682`, green `#859900`, yellow `#b58900`, red `#dc322f`, orange `#cb4b16`, base01 (comments/dim) `#586e75`, base0 (foreground) `#839496`. Terminal background is `#002b36` (base03). Neovim is the current exception (see above). qutebrowser defines the palette as named Python variables at the top of `qutebrowser/config.py`.

## Agent guidance

See `CLAUDE.md` for how AI coding agents (Claude Code, OpenCode, Codex CLI, etc.) should work in this repo — commit conventions, code style, and the issue-tracker/domain-doc skills. `AGENTS.md` is a symlink to `CLAUDE.md` so every tool reads the same, single source of truth.
