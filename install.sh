#!/usr/bin/env bash

# ========================================================
# File: install.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================

set -e

SCRIPTS_DIR=$(cd "$(dirname "$0")" && pwd)
source $SCRIPTS_DIR/env.sh

echo $SCRIPTS_DIR
DOTFILES_DIR=$SCRIPTS_DIR/dotfiles
source $SCRIPTS_DIR/install_omz.sh
source $SCRIPTS_DIR/install_v2ray.sh

echo "$INFO Home directory: $HOME"
echo "$INFO Linking dotfiles"
ln -sf $DOTFILES_DIR/.tmux.conf $HOME/.tmux.conf
ln -sf $DOTFILES_DIR/.vimrc $HOME/.vimrc
ln -sf $DOTFILES_DIR/.docker.zshrc $HOME/.docker.zshrc

echo "$INFO Installing v2ray"
install_v2ray
source $SCRIPTS_DIR/start_v2ray.sh

echo "$INFO Installing oh-my-zsh"
install_oh_my_zsh

ln -sf $DOTFILES_DIR/.deng.zshrc $HOME/.deng.zshrc
sed 's/^source $ZSH\/oh-my-zsh.sh/source $HOME\/.deng.zshrc\n&/' $HOME/.zshrc > $HOME/.new.zshrc
mv $HOME/.new.zshrc $HOME/.zshrc

echo "$INFO Done"
