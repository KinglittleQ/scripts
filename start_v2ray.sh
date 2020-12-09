#!/usr/bin/env bash

# ========================================================
# File: start_v2ray.zsh
# -----
# Author: Check Deng
# Email: checkdeng0903@gmail.com
# =======================================================


V2RAY_ROOT=$HOME/Software/v2ray
V2RAY=$V2RAY_ROOT/v2ray

nohup $V2RAY -config $V2RAY_ROOT/configs/config.json &

