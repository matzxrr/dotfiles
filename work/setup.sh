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

# Function to create symbolic link
install_link() {
    print "Installing symbolic link..." "$YELLOW"
    
    # Source and target for the link
    SOURCE="$HOME/work/ie"
    TARGET="$HOME/.ie"
    
    # Remove existing link if present
    if [ -L "$TARGET" ]; then
        rm -f "$TARGET"
    elif [ -f "$TARGET" ] || [ -d "$TARGET" ]; then
        print "Warning: $TARGET exists and is not a symbolic link. Removing it." "$RED"
        rm -rf "$TARGET"
    fi
    
    # Create symbolic link
    ln -s "$SOURCE" "$TARGET"
    print "Created link: $TARGET -> $SOURCE" "$GREEN"
    
    print "Installation complete!" "$GREEN"
    print "Please run 'source ~/.bashrc' or 'source ~/.bash_profile' to apply changes." "$YELLOW"
}

# Function to remove symbolic link
uninstall_link() {
    print "Uninstalling symbolic link..." "$YELLOW"
    
    # Target for the link
    TARGET="$HOME/.ie"
    
    # Remove symbolic link
    if [ -L "$TARGET" ]; then
        rm -f "$TARGET"
        print "Removed link: $TARGET" "$GREEN"
    else
        print "Link $TARGET doesn't exist or is not a symbolic link." "$YELLOW"
    fi
    
    print "Uninstallation complete!" "$GREEN"
    print "Please run 'source ~/.bashrc' or 'source ~/.bash_profile' to apply changes." "$YELLOW"
}

# Check for command line arguments
if [ $# -eq 0 ]; then
    print "Usage: $0 install|uninstall" "$RED"
    exit 1
fi

case "$1" in
    install)
        install_link
        ;;
    uninstall)
        uninstall_link
        ;;
    *)
        print "Unknown command: $1" "$RED"
        print "Usage: $0 install|uninstall" "$RED"
        exit 1
        ;;
esac
