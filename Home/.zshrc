neofetch


eval "$(starship init zsh)"
export ZSH="$HOME/.oh-my-zsh"

plugins=(git fzf-tab zsh-syntax-highlighting zsh-autosuggestions)

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="find \! \( -path '*/.git' -prune \) -printf '%P\n'"

source $ZSH/oh-my-zsh.sh

alias cat='bat'
alias ls='exa --icons -la'

if [ "$TERM" = "xterm-kitty" ] 
then
	alias img='kitten icat'
fi

[[ $- != *i* ]] && return

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
