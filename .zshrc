# export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"

DEFAULT_USER=nailxx
COMPLETION_WAITING_DOTS="true"

source ~/.dotfiles/zsh.d/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply
