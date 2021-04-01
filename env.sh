#!/usr/bin/env bash

# ========================================================
# File: env.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================

RED=`tput setaf 1`
YELLOW=`tput setaf 3`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

ERROR="${RED}[ERROR]$RESET"
WARN="${YELLOW}[WARN]$RESET"
INFO="${GREEN}[INFO]$RESET"

function echo_error() {
  echo "$ERROR $@"
}

function echo_warn() {
  echo "$WARN $@"
}

function echo_info() {
  echo "$INFO $@"
}

function lab() {
  if [[ "$(ip_address)" == *"10.76."* ]]; then
    echo 'CAD'
  elif [[ "$(ip_address)" == *"192.168."* ]]; then
    echo 'FABU'
  else
    echo 'unknown-host'
  fi
}

function server() {
  LAB=$(lab)
  if [ "$LAB" = "CAD" ]; then
    echo "cad-data.zjulearning.org:5000"
  elif [ "$LAB" = "FABU" ]; then
    echo "docker.fabu.ai:5000"
  else
    echo "unknown-server"
  fi
}

function login() {
  LAB=$(lab)
  if [ "$LAB" = "CAD" ]; then
    echo_info "Login into zjulearning docker server"
    docker login $(server) -u zjulearning -p zjulearning
  elif [ "$LAB" = "FABU" ]; then
    docker login $(server) -u fabu -p fabu
    echo_info "Login into fabu docker server"
  else
    echo_error "unknown-lab: $LAB"
    exit 1
  fi
}

function filter() {
  echo $1 | sed 's/\W/_/g'
}

function ip_address() {
  hostname -I | awk '{print $1}'
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
