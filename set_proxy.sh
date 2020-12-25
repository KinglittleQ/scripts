#!/usr/bin/env bash

# ========================================================
# File: set_proxy.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================

SCRIPTS_DIR=$(cd "$(dirname "$0")" && pwd)
source $SCRIPTS_DIR/env.sh

PROXY=$(proxy)

if [ $1 = "set" ] || [ $1 = "1" ]; then
	export http_proxy=$PROXY
	export https_proxy=$PROXY
	export HTTP_PROXY=$PROXY
	export HTTPS_PROXY=$PROXY
	export all_proxy=$PROXY
	export ALL_PROXY=$PROXY
	echo_info "Set proxy as $PROXY"
elif [ $1 = 'unset' ] || [ $1 = '0' ]; then
	export http_proxy=
	export http_proxy=
	export HTTP_PROXY=
	export HTTPS_PROXY=
	export all_proxy=
	export ALL_PROXY=
	echo_info "Unset proxy"
else
	echo_info "Invalid parameter (set|1, unset|0)"
fi


