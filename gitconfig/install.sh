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

# Check for command line arguments
if [ $# -eq 0 ]; then
    print "Usage: $0 personal|work" "$RED"
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_CONFIG="$SCRIPT_DIR/base"
WORK_CONFIG="$SCRIPT_DIR/work"
PERSONAL_CONFIG="$SCRIPT_DIR/personal"
TARGET_CONFIG="$HOME/.gitconfig"

# Function to create git config
create_config() {
    # Validate the config type
    if [ "$1" != "personal" ] && [ "$1" != "work" ]; then
        print "Invalid config type: $1. Use 'personal' or 'work'." "$RED"
        exit 1
    fi
    
    print "Creating $1 Git configuration..." "$YELLOW"
    
    # Ensure base config exists
    if [ ! -f "$BASE_CONFIG" ]; then
        print "Error: Base config file not found at $BASE_CONFIG" "$RED"
        exit 1
    fi
    
    # Combine base config with selected profile
    cat "$BASE_CONFIG" > "$TARGET_CONFIG"
    
    if [ "$1" = "work" ]; then
        if [ ! -f "$WORK_CONFIG" ]; then
            print "Error: Work config file not found at $WORK_CONFIG" "$RED"
            exit 1
        fi
        cat "$WORK_CONFIG" >> "$TARGET_CONFIG"
        print "Work Git configuration has been installed!" "$GREEN"
    else
        if [ ! -f "$PERSONAL_CONFIG" ]; then
            print "Error: Personal config file not found at $PERSONAL_CONFIG" "$RED"
            exit 1
        fi
        cat "$PERSONAL_CONFIG" >> "$TARGET_CONFIG"
        print "Personal Git configuration has been installed!" "$GREEN"
    fi
}

# Process command
create_config "$1"
