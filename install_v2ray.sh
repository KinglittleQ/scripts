#!/usr/bin/env bash

# ========================================================
# File: install_v2ray.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================

SCRIPTS_DIR=$(cd "$(dirname "$0")" && pwd)
source $SCRIPTS_DIR/env.sh

function install_v2ray() {
  PARENT=$(dirname "$v2ray_root")
  if [ ! -d "$PARENT" ]; then
    echo_info "$PARENT DOES NOT exists, we will make it" 
    mkdir -p $PARENT
  fi

  if [ ! -d "$(v2ray_root)" ]; then
    echo_info "Downloading v2ray ..."
    git clone git@git.zjulearning.org:Dengcq/v2ray.git $(v2ray_root)
  else
    echo_info "v2ray exists."
  fi

  echo_info "Successfully install v2ray"
}
