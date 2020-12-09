#!/usr/bin/env bash

# ========================================================
# File: install.zsh
# -----
# Author: Check Deng
# Email: checkdeng0903@gmail.com
# =======================================================

set -e

SCRIPTS_DIR=$(dirname "$0")
DOTFILES_DIR=$SCRIPTS_DIR/dotfiles

echo "Home directory: $HOME"

ln -sf $DOTFILES_DIR/.tmux.conf $HOME/.tmux.conf
ln -sf $DOTFILES_DIR/.vimrc $HOME/.vimrc
ln -sf $DOTFILES_DIR/.docker.zshrc $HOME/.docker.zshrc

./install_zsh.sh

ln -sf $DOTFILES_DIR/.deng.zshrc $HOME/.deng.zshrc
sed 's/^source $ZSH\/oh-my-zsh.sh/source $HOME\/.deng.zshrc\n&/' $HOME/.zshrc > $HOME/.new.zshrc
mv $HOME/.new.zshrc $HOME/.zshrc

echo "Done"
