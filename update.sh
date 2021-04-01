#!/usr/bin/env bash

# ========================================================
# File: update.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================

SCRIPTS_DIR=$(cd "$(dirname "$0")" && pwd)
source $SCRIPTS_DIR/env.sh

cd $SCRIPTS_DIR && git pull
cd $(v2ray_root) && git pull
