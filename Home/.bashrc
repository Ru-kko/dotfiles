#
# ~/.bashrc
#
neofetch
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias cat='bat'
alias ls='exa --icons -la'

eval "$(starship init bash)"
export FZF_CTRL_T_COMMAND="find \! \( -path '*/.git' -prune \) -printf '%P\n'"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
