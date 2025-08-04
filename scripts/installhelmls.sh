#!/bin/bash

# Download the latest helm-ls binary for Linux AMD64
curl -L https://github.com/mrjosh/helm-ls/releases/download/master/helm_ls_linux_amd64 -o helm_ls

# Make it executable
chmod +x helm_ls

# Move it to a directory in your PATH
sudo mv helm_ls /usr/local/bin/helm_ls

# Verify installation
helm_ls version
