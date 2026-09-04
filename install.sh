#!/usr/bin/env bash
# Dotfiles installer for the JRiveraWSS/dotfiles repo.
#
# Idempotent: safe to run multiple times. Everything it does is also
# reversible; backed-up files (renamed to *.bak) are never deleted.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
LOCAL_BIN="${HOME}/.local/bin"

# Command-line flags
CHECK_MODE=0
SKIP_HIDPI=0

usage() {
	cat <<'EOF'
Usage: install.sh [options]

Options:
  --check      Dry run: print what would change, change nothing.
  --skip-hidpi Skip the HiDPI / fractional-scaling gsettings block.
  -h, --help   Show this help.
EOF
}

log()  { printf '\033[1;34m[install]\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m[ok]\033[0m      %s\n' "$*"; }
warn() { printf '\033[1;33m[warn]\033[0m    %s\n' "$*" >&2; }
err()  { printf '\033[1;31m[error]\033[0m   %s\n' "$*" >&2; }

for arg in "$@"; do
	case "$arg" in
		--check) CHECK_MODE=1 ;;
		--skip-hidpi) SKIP_HIDPI=1 ;;
		-h|--help) usage; exit 0 ;;
		*) err "Unknown option: $arg"; usage; exit 1 ;;
	esac
done

link_file() {
	local src="$1" dst="$2"

	if [[ "$(readlink -f "$src" 2>/dev/null)" = "$(readlink -f "$dst" 2>/dev/null)" ]]; then
		ok "$dst already points to $src"
		return 0
	fi

	if [[ -e "$dst" || -L "$dst" ]]; then
		if [[ "$CHECK_MODE" = 0 ]]; then
			cp -a "$dst" "${dst}.bak"
			ok "backed up existing $dst to ${dst}.bak"
		else
			warn "would back up existing $dst to ${dst}.bak"
		fi
	fi

	if [[ "$CHECK_MODE" = 0 ]]; then
		mkdir -p "$(dirname "$dst")"
		ln -sf "$src" "$dst"
		ok "linked $src -> $dst"
	else
		warn "would link $src -> $dst"
	fi
}

symlink_target() {
	# Symlink the given source path to the given destination, creating the
	# parent directory as needed.
	link_file "$@"
}

bin_shim() {
	local cmd="$1" target="$2" shim="$LOCAL_BIN/$2"
	if [[ -e "$shim" || -L "$shim" ]]; then
		ok "shim for $cmd already present at $shim"
		return 0
	fi
	if [[ "$CHECK_MODE" = 0 ]]; then
		mkdir -p "$LOCAL_BIN"
		ln -s "$(command -v "$cmd")" "$shim"
		ok "created shim $shim -> $(command -v "$cmd")"
	else
		warn "would create shim $shim -> $(command -v "$cmd")"
	fi
}

# ---------------------------------------------------------------------------
# 1. Symlink config dirs/files
# ---------------------------------------------------------------------------
log "Linking config files"

link_file "$DOTFILES_DIR/zsh" "$XDG_CONFIG_HOME/zsh"
link_file "$DOTFILES_DIR/ghostty/config" "$XDG_CONFIG_HOME/ghostty/config"
link_file "$DOTFILES_DIR/nvim" "$XDG_CONFIG_HOME/nvim"
link_file "$DOTFILES_DIR/yazi" "$XDG_CONFIG_HOME/yazi"
link_file "$DOTFILES_DIR/qutebrowser/config.py" "$XDG_CONFIG_HOME/qutebrowser/config.py"
link_file "$DOTFILES_DIR/opencode" "$XDG_CONFIG_HOME/opencode"
link_file "$DOTFILES_DIR/Xresources" "$HOME/.Xresources"
link_file "$DOTFILES_DIR/codex/config.toml" "$HOME/.codex/config.toml"

# ---------------------------------------------------------------------------
# 2. Prerequisite check
# ---------------------------------------------------------------------------
log "Checking prerequisites"

PREREQS=(nvim zsh fzf fd eza bat zoxide starship uv yazi rg)
for tool in "${PREREQS[@]}"; do
	if ! command -v "$tool" >/dev/null 2>&1; then
		warn "$tool is not on PATH"
	fi
done

# bat may be shipped as batcat on Debian/Ubuntu
if ! command -v bat >/dev/null 2>&1 && command -v batcat >/dev/null 2>&1; then
	warn "bat not found but batcat is; creating shim"
	bin_shim batcat bat
else
	ok "bat resolved"
fi

# ---------------------------------------------------------------------------
# 3. qutebrowser: pin session PATH in .desktop launcher
# ---------------------------------------------------------------------------
log "Pinning qutebrowser .desktop launcher"

DESKTOP_SRC="/usr/share/applications/org.qutebrowser.qutebrowser.desktop"
DESKTOP_DST="$XDG_DATA_HOME/applications/org.qutebrowser.qutebrowser.desktop"
QB_USER_BIN="$LOCAL_BIN/qutebrowser"

QB_ARCHIVE=$(command -v qutebrowser || true)
QB_ACTIVE="$QB_USER_BIN"
[[ -x "$QB_ACTIVE" ]] || QB_ACTIVE="$QB_ARCHIVE"

if [[ -f "$DESKTOP_DST" ]] && [[ -n "$QB_ACTIVE" ]] && grep -q "Exec=$QB_ACTIVE" "$DESKTOP_DST" 2>/dev/null; then
	ok ".desktop override already pins $QB_ACTIVE"
elif [[ -f "$DESKTOP_SRC" ]] && [[ -n "$QB_ACTIVE" ]]; then
	if [[ "$CHECK_MODE" = 0 ]]; then
		mkdir -p "$(dirname "$DESKTOP_DST")"
		sed "s|^Exec=qutebrowser |Exec=$QB_ACTIVE |" "$DESKTOP_SRC" > "$DESKTOP_DST"
		ok "wrote .desktop override pinning $QB_ACTIVE"
	else
		warn "would write .desktop override pinning $QB_ACTIVE"
	fi
elif [[ -n "$QB_ACTIVE" ]]; then
	warn "no launchable source .desktop at $DESKTOP_SRC; leaving existing override in place"
else
	warn "qutebrowser not found on PATH"
fi

# ---------------------------------------------------------------------------
# 4. yazi plugins
# ---------------------------------------------------------------------------
log "Installing yazi plugins"

if [[ -f "$DOTFILES_DIR/yazi/package.toml" ]] && command -v ya >/dev/null 2>&1; then
	if [[ -d "$XDG_CONFIG_HOME/yazi/plugins" ]] && [[ "$(ls -A "$XDG_CONFIG_HOME/yazi/plugins" 2>/dev/null)" ]]; then
		ok "yazi plugins already installed"
	else
		if [[ "$CHECK_MODE" = 0 ]]; then
			(cd "$XDG_CONFIG_HOME/yazi" && ya pkg install)
			ok "installed yazi plugins"
		else
			warn "would run 'ya pkg install' in $XDG_CONFIG_HOME/yazi"
		fi
	fi
else
	warn "yazi package.toml or 'ya' not found; skipping plugin install"
fi

# ---------------------------------------------------------------------------
# 5. HiDPI fractional scaling (once)
# ---------------------------------------------------------------------------
if [[ "$SKIP_HIDPI" = 1 ]]; then
	log "Skipping HiDPI setup (--skip-hidpi)"
elif ! command -v gsettings >/dev/null 2>&1 || [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" ]]; then
	log "Skipping HiDPI setup (no gsettings / not on a display)"
else
	log "Configuring HiDPI fractional scaling"

	CURRENT_SCALING=$(gsettings get org.gnome.desktop.interface scaling-factor 2>/dev/null || true)
	if [[ "$CURRENT_SCALING" != *"1"* ]]; then
		if [[ "$CHECK_MODE" = 0 ]]; then
			gsettings set org.gnome.desktop.interface scaling-factor 1
			ok "set scaling-factor to 1"
		else
			warn "would set scaling-factor to 1"
		fi
	else
		ok "scaling-factor already 1"
	fi

	CURRENT_EXPERIMENTAL=$(gsettings get org.gnome.mutter experimental-features 2>/dev/null || true)
	if [[ "$CURRENT_EXPERIMENTAL" != *"x11-randr-fractional-scaling"* ]]; then
		if [[ "$CHECK_MODE" = 0 ]]; then
			gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"
			ok "enabled x11-randr-fractional-scaling"
		else
			warn "would enable x11-randr-fractional-scaling"
		fi
	else
		ok "fractional scaling already enabled"
	fi

	if [[ "$CHECK_MODE" = 0 ]]; then
		xrdb -merge "$HOME/.Xresources" 2>/dev/null && ok "merged .Xresources" || warn "xrdb not available"
	else
		warn "would merge .Xresources via xrdb"
	fi
fi

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
if [[ "$CHECK_MODE" = 1 ]]; then
	log "Dry run complete (nothing changed)."
else
	log "Done. Start a new shell or log out/in to pick up changes."
fi