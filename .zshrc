# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias vi='nvim'
alias i='sudo pacman -S'
alias il='pacman -Ss'
alias upd='sudo pacman -Syu'
alias rmv='sudo pacman -Rns'
alias iy='yay -S'
alias iyl='yay -Ss'
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'
alias ls='exa'
alias bt='bat'
alias ff='fastfetch'
alias fm='yazi'
alias sl='ls'
alias cd='z'

# Starship prompt
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PATH=$PATH:/home/steban/.spicetify

# pnpm
export PNPM_HOME="/home/steban/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
eval "$(zoxide init zsh)"
