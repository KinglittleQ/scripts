#!/usr/bin/env bash

# ========================================================
# File: docker_exec.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================


SHELL="zsh"
WORK_DIR="$(pwd)"
BASE_DIR="$(basename $WORK_DIR)"
DOCKER_NAME="dev_in_$BASE_DIR"

function main() {
  docker exec -it \
         -e COLORTERM=$COLORTERM \
         $DOCKER_NAME \
         $SHELL
}

main
