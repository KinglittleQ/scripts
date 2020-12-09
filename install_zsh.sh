#!/usr/bin/env bash

# ========================================================
# File: install_zsh.sh
# -----
# Author: Check Deng
# Email: checkdeng0903@gmail.com
# =======================================================

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "oh-my-zsh DOES NOT exists." 
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh exists."
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  echo "zsh-autosuggestions DOES NOT exists." 
  git clone https://github.com/zsh-users/zsh-autosuggestions \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
  echo "zsh-autosuggestions exists."
fi
