#!/bin/bash

# Define the version variable
VERSION="v0.49.0"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for git
if ! command_exists git; then
    echo "Error: git is not installed. Please install git and try again."
    exit 1
fi

# Check for go
if ! command_exists go; then
    echo "Error: Go is not installed. Please install Go and try again."
    exit 1
fi

# Create a temporary directory
TMP_DIR=$(mktemp -d)

# Clone the LazyGit repository into the temporary directory
git clone https://github.com/jesseduffield/lazygit.git "$TMP_DIR/lazygit"

# Navigate into the LazyGit directory
cd "$TMP_DIR/lazygit"

# Checkout the specified version
git checkout tags/$VERSION

# Install LazyGit using Go
go install

echo "LazyGit version $VERSION installation complete!"
