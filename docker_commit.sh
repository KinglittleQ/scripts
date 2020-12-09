#!/usr/bin/env bash

AUTHOR="Check Deng <checkdeng0903@gmail.com>"

function main() {
  if [ "$#" -ne 4 ]; then 
    echo "Usage: $0 container new_image message"
    exit 1
  fi
  docker commit -a $AUTHOR $1 $2 -m $3
}

main $1 $2 $3
