#!/usr/bin/env bash

# ========================================================
# File: install_omz.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================

SCRIPTS_DIR=$(cd "$(dirname "$0")" && pwd)
source $SCRIPTS_DIR/env.sh

function install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "$INFO oh-my-zsh DOES NOT exists, downloading ..." 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "$INFO oh-my-zsh exists."
  fi

  if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    echo "$INFO zsh-autosuggestions DOES NOT exists, downloading ..." 
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  else
    echo "$INFO zsh-autosuggestions exists."
  fi
}