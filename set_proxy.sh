#!/bin/bash

PROXY=127.0.0.1:7891

if [ $1 = "set" ] || [ $1 = "1" ]; then
	export http_proxy=$PROXY
	export https_proxy=$PROXY
	export HTTP_PROXY=$PROXY
	export HTTPS_PROXY=$PROXY
	export all_proxy=$PROXY
	export ALL_PROXY=$PROXY
	echo "set proxy as $PROXY"
elif [ $1 = 'unset' ] || [ $1 = '0' ]; then
	export http_proxy=
	export http_proxy=
	export HTTP_PROXY=
	export HTTPS_PROXY=
	export all_proxy=
	export ALL_PROXY=
	echo "unset proxy"
else
	echo "Invalid parameter (set|1, unset|0)"
fi


