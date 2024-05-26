neofetch


eval "$(starship init zsh)"
export ZSH="$HOME/.oh-my-zsh"

plugins=(git fzf-tab zsh-syntax-highlighting zsh-autosuggestions)

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="find \! \( -path '*/.git' -prune \) -printf '%P\n'"

source $ZSH/oh-my-zsh.sh

alias cat='bat'
alias ls='eza --icons -la'

if [ "$TERM" = "xterm-kitty" ] 
then
	alias img='kitten icat'
fi

[[ $- != *i* ]] && return

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# path
export PATH="$HOME/go/bin:$HOME/.local/bin:$PATH"
