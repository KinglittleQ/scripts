#!/usr/bin/env bash

# ========================================================
# File: get_lab.zsh
# -----
# Author: Check Deng
# Email: checkdeng0903@gmail.com
# =======================================================

func get_lab() {
  if [[ "$(hostname)" == *"cad"* ]]; then
    echo 'CAD'
  else
    echo 'FABU'
  fi
}