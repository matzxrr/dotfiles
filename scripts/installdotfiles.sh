#!/bin/bash

git clone --bare https://github.com/mattdevio/dotfiles.git $HOME/.cfg
function config {
	/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME $@
}

config checkout
if [ $? = 0 ]; then
	echo "Checked out config.";
else
	echo "Backing up pre-existing dot files into '.config-backup'";
	mkdir -p .config-backup
	config ls-tree -r HEAD --name-only | awk {'print $1'} | xargs dirname | awk '!NF || !seen[$0]++' | xargs -I {} mkdir -p .config-backup/{}
	config ls-tree -r HEAD --name-only | awk {'print $1'} | xargs -I {} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
