#!/bin/sh

system_type=$(uname -s)

pretty_print() {
    printf "\n%b\n" "$1"
}

pretty_print "Installing nvm..."

if [ ! -d "${HOME}/.nvm/.git" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    source ~/.bash_profile
    nvm install 16.19.0
    nvm alias default 16.19.0
    nvm use default
    pretty_print "Done"
else
    pretty_print "Already installed"
fi

