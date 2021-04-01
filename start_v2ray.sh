#!/usr/bin/env bash

# ========================================================
# File: start_v2ray.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================

SCRIPTS_DIR=$(cd "$(dirname "$0")" && pwd)
source $SCRIPTS_DIR/env.sh
V2RAY=$(v2ray_root)/v2ray

pkill v2ray
nohup $V2RAY -config $(v2ray_root)/configs/config.json > /tmp/v2ray_log &

