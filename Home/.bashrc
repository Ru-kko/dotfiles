#
# ~/.bashrc
#
neofetch
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias cat='bat'
alias ls='eza --icons -la'

eval "$(starship init bash)"
export FZF_CTRL_T_COMMAND="find \! \( -path '*/.git' -prune \) -printf '%P\n'"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH="$HOME/go/bin:$HOME/.local/bin:$PATH"


[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env
