# Powerful but minimal zsh configuration
#
# Uses:
#   Plugins:      fast-syntax-highlighting, zsh-autosuggestions,
#                 zsh-history-substring-search, zsh-vi-mode
#   Prompt:       starship
#   Navigation:   zoxide, fzf, fd
#   CLI tools:    eza, bat, nvim, ripgrep
#   Node:         nvm

# History

HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "${HISTFILE:h}"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# Shell behaviour

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# Smart directory navigation

# Initialize zoxide
eval "$(zoxide init zsh)"

# Completion

# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
ZCOMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"
mkdir -p "${ZCOMPDUMP:h}"
# Only run the full security audit once every 24h; otherwise trust the
# existing dump (-C) to avoid compaudit's cost on every shell start.
if [[ -n "$ZCOMPDUMP"(#qN.mh+24) ]]; then
  compinit -d "$ZCOMPDUMP"
else
  compinit -C -d "$ZCOMPDUMP"
fi
unset ZCOMPDUMP

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower

# Fuzzy finder

# Ubuntu
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# Modular Config Files

# fzf configuration
source "$ZDOTDIR/fzf.zsh"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Custom keybindings
source "$ZDOTDIR/bindings.zsh"

# Plugins and plugin manager
source "$ZDOTDIR/plugins.zsh"

# Prompt/theme
source "$ZDOTDIR/prompt.zsh"


# Node / NVM

# Lazy-load nvm: sourcing nvm.sh eagerly adds ~300ms to every shell start.
# Defer it until node/npm/npx/nvm (or a project's package manager) is
# actually invoked.
export NVM_DIR="$HOME/.nvm"

_nvm_lazy_load() {
  local cmd
  for cmd in nvm node npm npx yarn pnpm corepack; do
    unfunction "$cmd" 2>/dev/null
  done
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

for _cmd in node npm npx yarn pnpm corepack; do
  eval "${_cmd}() { _nvm_lazy_load; command ${_cmd} \"\$@\"; }"
done
# nvm itself is a shell function, not an executable, so it can't go through `command`
nvm() { _nvm_lazy_load; nvm "$@"; }
unset _cmd

# Bun

[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"
