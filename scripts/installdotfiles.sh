#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function print {
        echo -e "$1\n"
}

function config {
        /usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME $@
}

print "Cloning..."
git clone --bare git@github.com:mattdevio/dotfiles.git $HOME/.cfg

print "Attempting checkout..."
config checkout

if [ $? = 0 ]; then
        print "Checked out config...";
else
        print "Backing up pre-existing dot files into '.config-backup'";
        mkdir -p .config-backup
        config ls-tree -r HEAD --name-only | awk {'print $1'} | xargs dirname | awk '!NF || !seen[$0]++' | xargs -I {} mkdir -p .config-backup/{}
        config ls-tree -r HEAD --name-only | awk {'print $1'} | xargs -I {} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no

print "${GREEN}Done${NC}"
