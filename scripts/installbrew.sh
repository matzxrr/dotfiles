#!/bin/sh

system_type=$(uname -s)

pretty_print() {
    printf "\n%b\n" "$1"
}

pretty_print "Installing homebrew..."

if [[ "$system_type" != "Darwin" ]]; then
    pretty_print "Not MacOS, skiping..."
    return 0;
fi

pretty_print "Checking for homebrew..."

if ! command -v brew &>/dev/null; then
    pretty_print "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    pretty_print "Done"
else
    pretty_print "Already exists!"
fi

if [[ -f "$HOMEBREW_BUNDLE_FILE" ]]; then
    pretty_print "Installing homebrew bundle"
    brew bundle install
fi
