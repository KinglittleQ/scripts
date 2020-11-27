#!/usr/bin/env bash

SHELL="zsh"
DOCKER_NAME="dengchengqi_dev_pytorch"

function main() {
  docker exec -it \
         -e COLORTERM=$COLORTERM \
         $DOCKER_NAME \
         $SHELL
}

main
