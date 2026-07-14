# ~/.config/zsh/.zshenv

# XDG base directories
# Centralizes config/cache/data locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Editor
# Default editor used by git, crontab, etc.
export EDITOR="nvim"
export VISUAL="nvim"

# Pager
if command -v bat >/dev/null 2>&1; then
  export MANPAGER="bat -l man -p"
elif command -v batcat >/dev/null 2>&1; then
  export MANPAGER="batcat -l man -p"
fi

# GPG
export GPG_TTY=$(tty)

# Starship
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# PATH
# Personal binaries/scripts
export PATH="$HOME/.local/bin:$PATH"

# Tool directories
export BUN_INSTALL="$HOME/.bun"
for _dir in \
  "$HOME/.cargo/bin" \
  "$HOME/.opencode/bin" \
  "$HOME/.lmstudio/bin" \
  "$BUN_INSTALL/bin"; do
  [[ -d "$_dir" ]] && export PATH="$_dir:$PATH"
done
unset _dir

# NVM-managed Node.js
# .zshrc lazy-loads nvm to keep interactive shell startup fast, but that means
# `node` is only a shell function until triggered — invisible to processes
# that exec commands directly (e.g. Neovim spawning an LSP server). Expose the
# highest installed version's bin dir here so non-interactive/direct-exec
# contexts can still find `node`/`npm`/`npx`.
export NVM_DIR="$HOME/.nvm"
if [[ -d "$NVM_DIR/versions/node" ]]; then
  _nvm_default_version="$(command ls "$NVM_DIR/versions/node" | sort -V | tail -1)"
  [[ -n "$_nvm_default_version" ]] && export PATH="$NVM_DIR/versions/node/$_nvm_default_version/bin:$PATH"
  unset _nvm_default_version
fi
