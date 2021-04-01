# ========================================================
# File: .docker.zshrc
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================


export ZSH=~/.oh-my-zsh

ZSH_THEME="ys"

plugins=(
  git
  zsh-autosuggestions
)

source $HOME/.deng.zshrc
source $ZSH/oh-my-zsh.sh

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

export LC_ALL=en_US.utf8
export TERM=xterm-256color
