export PATH=/usr/local/bin:$PATH
export PATH=./node_modules/.bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.gem/ruby/2.4.0/bin:$PATH
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
antigen bundle docker
antigen bundle yarn
antigen bundle systemd
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm

antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply
