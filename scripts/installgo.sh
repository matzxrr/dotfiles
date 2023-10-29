#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

HERE=$(pwd)
cd /tmp
wget https://go.dev/dl/go1.21.3.linux-amd64.tar.gz

# Remove previous GO and extract in /usr/local/go
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.3.linux-amd64.tar.gz
cd "$HERE"
