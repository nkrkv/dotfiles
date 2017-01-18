export PATH=./node_modules/.bin:$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"

DEFAULT_USER=nailxx
COMPLETION_WAITING_DOTS="true"

source ~/.dotfiles/zsh.d/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply
