#!/bin/bash

# ========================================================
# File: install.zsh
# -----
# Author: Check Deng
# Email: checkdeng0903@gmail.com
# =======================================================


set -e

echo "Home directory: $HOME"

ln -sf $PWD/.tmux.conf $HOME/.tmux.conf
ln -sf $PWD/.vimrc $HOME/.vimrc
ln -sf $PWD/.docker.zshrc $HOME/.docker.zshrc

./install_zsh.sh

ln -sf $PWD/.deng.zshrc $HOME/.deng.zshrc
sed 's/^source $ZSH\/oh-my-zsh.sh/source $HOME\/.deng.zshrc\n&/' $HOME/.zshrc > $HOME/.new.zshrc
mv $HOME/.new.zshrc $HOME/.zshrc

if [[ "$(hostname)" == *"cad"* ]]; then
  echo 'export LAB=CAD' >> $HOME/.zshrc
  echo 'set LAB as CAD'
else
  echo 'export LAB=FABU' >> $HOME/.zshrc
  echo 'set LAB as FABU'
fi

echo "Done"
