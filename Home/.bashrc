#
# ~/.bashrc
#
neofetch
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='lsd -al'
alias cat='bat'


[ -f ~/.fzf.bash ] && source ~/.fzf.bash


powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
