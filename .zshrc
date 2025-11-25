# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Vim mode
bindkey -v

# Tokyo Night Storm: Faint blue for suggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#545c7e'

# Tokyo Night Storm syntax-highlighting

# Make sure truecolor is on
export ZSH_HIGHLIGHT_STYLES_PATH=true

# Command words (builtin/alias/external)
ZSH_HIGHLIGHT_STYLES[command]='fg=#7aa2f7'             # Blue
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[function]='fg=#bb9af7'            # Magenta
ZSH_HIGHLIGHT_STYLES[alias]='fg=#e0af68'               # Yellow

# Arguments
ZSH_HIGHLIGHT_STYLES[argument]='fg=#a9b1d6'            # Main foreground

# Options (e.g., -a)
ZSH_HIGHLIGHT_STYLES[option]='fg=#7dcfff'              # Cyan

# Path (files/folders)
ZSH_HIGHLIGHT_STYLES[path]='fg=#73daca'                # Green

# Globs (* ? etc.)
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#bb9af7'            # Magenta

# Strings
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#9ece6a'   # Green
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#9ece6a'

# Command substitution (`...` or $(...))
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#f7768e'     # Red
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#e0af68'   # Yellow

# Variables ($FOO)
ZSH_HIGHLIGHT_STYLES[dollar-parameter]='fg=#bb9af7'         # Magenta

# Comments
ZSH_HIGHLIGHT_STYLES[comment]='fg=#545c7e'                  # Dim gray-blue

# Redirections
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#e0af68'              # Yellow

# Errors
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e,bold'       # Bright red

# Default foreground
ZSH_HIGHLIGHT_STYLES[default]='fg=#a9b1d6'

# >>> nvim-linux-x86_64 PATH >>>
if [ -d "\/home/jrivera/nvim-linux-x86_64/bin" ]; then
  export PATH="\/home/jrivera/nvim-linux-x86_64/bin:\/home/jrivera/.local/bin:/home/jrivera/.nvm/versions/node/v23.8.0/bin:/home/jrivera/.cargo/bin:/home/jrivera/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/jrivera/.dotnet/tools"
fi
# <<< nvim-linux-x86_64 PATH <<<

export EDITOR=nvim
export VISUAL=nvim

# Auto-start Zellij on interactive shells
if [[ $- == *i* ]]; then
  if command -v zellij >/dev/null 2>&1; then
    # Skip if already in a multiplexer or certain terminals
    if [[ -z "$ZELLIJ" && -z "$TMUX" && "$TERM" != "linux" && "$TERM_PROGRAM" != "vscode" ]]; then
      # Opt-out switch: export NO_ZELLIJ=1 to disable
      if [[ -z "$NO_ZELLIJ" ]]; then
        zellij
        exit    # exit the shell when Zellij exits (cleaner)
      fi
    fi
  fi
fi

eval "$(starship init zsh)"

# opencode
export PATH=/home/jrivera/.opencode/bin:$PATH

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/jrivera/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/jrivera/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/jrivera/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/jrivera/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

