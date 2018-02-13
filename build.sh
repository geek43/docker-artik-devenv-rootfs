#!/bin/bash
set -ev

if [ "$#" -ne 1 ]; then
	echo "Illegal number of parameters"
	exit 1
fi

TARGET=$1

if [[ $TARGET == f* ]]; then
	./build_fedora.sh $TARGET
elif [[ $TARGET == u* ]]; then
	./build_ubuntu.sh $TARGET
else
	echo "Not supported target: $TARGET"
	exit 1
fi
