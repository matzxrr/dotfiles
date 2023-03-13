#!/bin/bash

# Install essential tools
sudo apt install build-essential libreadline-dev unzip

# Install lua
curl -R -O https://www.lua.org/ftp/lua-5.3.5.tar.gz
tar -zxf lua-5.3.5.tar.gz
cd lua-5.3.5
make linux test
sudo make install

# download luarocks
wget https://luarocks.org/releases/luarocks-3.8.0.tar.gz
tar zxpf luarocks-3.8.0.tar.gz
cd luarocks-3.8.0

# install luarocks
./configure --with-lua-include=/usr/local/include
make
sudo make install
