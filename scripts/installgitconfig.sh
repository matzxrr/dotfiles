#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to print message with color
print() {
    echo -e "${2:-$NC}$1${NC}\n"
}

CONFIG_SOURCE=""
CONFIG_DIR="$HOME/.config/gitconfig"

# Check for command line arguments
if [ $# -eq 0 ]; then
    print "Usage: $0 [personal|work-blade|work-laptop]" "$RED"
    exit 1
fi

case "$1" in
    personal)
        CONFIG_SOURCE="$CONFIG_DIR/personal"
        ;;
    work-blade)
        CONFIG_SOURCE="$CONFIG_DIR/work-blade"
        ;;
    work-laptop)
        CONFIG_SOURCE="$CONFIG_DIR/work-laptop"
        ;;
    *)
        print "Unknown configuration: $1" "$RED"
        print "Usage: $0 [personal|work-blade|work-laptop]" "$RED"
        exit 1
        ;;
esac

# Backup existing gitconfig if it exists
if [ -f "$HOME/.gitconfig" ]; then
    BACKUP_FILE="$HOME/.gitconfig.backup-$(date +%Y%m%d-%H%M%S)"
    print "Backing up existing .gitconfig to $BACKUP_FILE" "$YELLOW"
    cp "$HOME/.gitconfig" "$BACKUP_FILE"
fi

# Copy the selected config to .gitconfig
print "Setting up $1 git configuration..." "$YELLOW"
cp "$CONFIG_SOURCE" "$HOME/.gitconfig"

if [ $? -eq 0 ]; then
    print "Successfully configured git with $1 settings!" "$GREEN"
else
    print "Failed to copy the gitconfig file." "$RED"
    exit 1
fi

# Print configuration details
print "Git configuration details:" "$YELLOW"
git config --get user.name
git config --get user.email
git config --get-regexp "^commit"
