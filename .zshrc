export PATH=./node_modules/.bin:$HOME/bin:/usr/local/bin:$PATH
export EDITOR=vim
export TERM="xterm-256color"

DEFAULT_USER=nailxx
COMPLETION_WAITING_DOTS="true"

# Rehash autocompletion real-time
zstyle ":completion:*:commands" rehash 1

source ~/.dotfiles/zsh.d/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle git-extras
antigen bundle systemd
antigen bundle clipboard
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply
