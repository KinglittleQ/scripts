#!/usr/bin/env bash

# ========================================================
# File: docker_exec.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================

SCRIPTS_DIR=$(cd "$(dirname "$0")" && pwd)
source $SCRIPTS_DIR/env.sh

TAG="v0.4"
SHELL="zsh"
WORK_DIR="$(pwd)"
BASE_DIR="$(basename $WORK_DIR)"

DOCKER_NAME=$(filter "dev_in_$BASE_DIR:$TAG")

function main() {
  docker exec -it \
         -e COLORTERM=$COLORTERM \
         $DOCKER_NAME \
         $SHELL
}

main
