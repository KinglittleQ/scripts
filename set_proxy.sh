#!/bin/bash

PROXY=127.0.0.1:7891

if [ $1 = "set" ] || [ $1 = "1" ]; then
	export http_proxy=$PROXY
	export https_proxy=$PROXY
	echo "set proxy as $PROXY"
elif [ $1 = 'unset' ] || [ $1 = '0' ]; then
	export http_proxy=
	export http_proxy=
	echo "unset proxy"
else
	echo "Invalid parameter (set|1, unset|0)"
fi


