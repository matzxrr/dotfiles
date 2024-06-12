#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function print {
        echo -e "$1\n"
}

print "Installing TPM..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

print "${GREEN}Done${NC}"

print "${RED}Make sure you run '<ctrl+b> I' to install plugins${NC}"
