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

function set_proxy() {
	if type conda &> /dev/null; then
		conda config --set proxy_servers.http $(http_proxy)
		conda config --set proxy_servers.https $(http_proxy)
	else
		echo_warn "Could not find conda, skip it"
	fi

	pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
			&> /dev/null | true
	pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
			&> /dev/null | true

	alias sudo='sudo '
	alias apt='apt -o Acquire::http::proxy=$(http_proxy)'
}

function unset_proxy() {
	if type conda &> /dev/null; then
		conda config --remove-key proxy_servers.http &> /dev/null || true
		conda config --remove-key proxy_servers.https &> /dev/null || true
	else
		echo_warn "Could not find conda, skip it"
	fi

	pip config set global.index-url &> /dev/null
	pip3 config set global.index-url &> /dev/null

	unalias sudo apt &> /dev/null
}

if [ $1 = "set" ] || [ $1 = "1" ]; then
	export http_proxy=$PROXY
	export https_proxy=$PROXY
	export HTTP_PROXY=$PROXY
	export HTTPS_PROXY=$PROXY
	export all_proxy=$PROXY
	export ALL_PROXY=$PROXY
	set_proxy
	echo_info "Set proxy as $PROXY"
elif [ $1 = 'unset' ] || [ $1 = '0' ]; then
	export http_proxy=
	export http_proxy=
	export HTTP_PROXY=
	export HTTPS_PROXY=
	export all_proxy=
	export ALL_PROXY=
	unset_proxy
	echo_info "Unset proxy"
else
	echo_info "Invalid parameter (set|1, unset|0)"
fi


