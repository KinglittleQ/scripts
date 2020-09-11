#!/bin/bash

V2RAY_ROOT=~/Software/v2ray
V2RAY=$V2RAY_ROOT/v2ray

nohup $V2RAY -config $V2RAY_ROOT/configs/config.json &

