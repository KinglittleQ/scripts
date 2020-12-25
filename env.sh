#!/usr/bin/env bash

# ========================================================
# File: get_lab.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================

RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
ERROR="${RED}[ERROR]$RESET"
INFO="${GREEN}[INFO]$RESET"

function echo_error() {
  echo "$ERROR $@"
}

function echo_info() {
  echo "$INFO $@"
}

function lab() {
  if [[ "$(hostname)" == *"cad"* ]]; then
    echo 'CAD'
  elif [[ "$(hostname)" == *"fabu"* ]]; then
    echo 'FABU'
  else
    echo 'Unknown host'
  fi
}

function server() {
  LAB=$(lab)
  if [ "$LAB" = "CAD" ]; then
    echo "cad-data.zjulearning.org:5000"
  elif [ "$LAB" = "FABU" ]; then
    echo "docker.fabu.ai:5000"
  fi
}

function login() {
  if [ "$LAB" = "CAD" ]; then
    echo_info "Login into zjulearning docker server"
    docker login $(server) -u zjulearning -p zjulearning
  elif [ "$LAB" = "FABU" ]; then
    docker login $(server) -u fabu -p fabu
    echo_info "Login into fabu docker server"
  else
    echo_error "Unknown lab: $LAB"
  fi
}

function proxy() {
  echo "127.0.0.1:7891"
}

function http_proxy() {
  echo "http://$(proxy)"
}

function v2ray_root() {
  echo "$HOME/Software/v2ray"
}
