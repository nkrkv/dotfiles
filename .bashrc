source ~/.dotfiles/bash.d/env
source ~/.dotfiles/bash.d/config
source ~/.dotfiles/bash.d/aliases

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/home/nailxx/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
