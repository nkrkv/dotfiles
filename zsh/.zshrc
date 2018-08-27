export PATH=/usr/local/bin:$PATH
export PATH=./node_modules/.bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.gem/ruby/2.4.0/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export EDITOR=nvim
export TERM="xterm-256color"
export FZF_DEFAULT_COMMAND='fd --type f --follow'

# Project env vars
export XOD_PRODUCTION_CONTEXT=gke_xodio-146312_us-central1-a_production
export XOD_STAGING_CONTEXT=gke_xodio-146312_us-central1-a_staging
export AMPERKA_THEME_REVIEW=1023854
export AMPERKA_THEME_PRODUCTION=1041717

alias e=nvim-gtk
alias o=xdg-open

DEFAULT_USER=nailxx
COMPLETION_WAITING_DOTS="true"

# Rehash autocompletion real-time
zstyle ":completion:*:commands" rehash 1

# Enable zmv
autoload -U zmv

# Antigen provided by `yaourt -Sy antigen-git`
source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle git-extras
antigen bundle docker
antigen bundle kubectl
antigen bundle yarn
antigen bundle systemd
antigen bundle clipboard
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm

#antigen theme bhilburn/powerlevel9k powerlevel9k

# Theme https://github.com/sindresorhus/pure
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
export PURE_PROMPT_SYMBOL="$"

antigen apply
