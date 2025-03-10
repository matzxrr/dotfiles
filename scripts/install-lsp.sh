#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Function to display error and exit
check_dependency() {
  if ! command_exists "$1"; then
    echo "Error: Required dependency '$1' not found."
    echo "Please install '$1' before running this script."
    exit 1
  fi
}

echo "Checking dependencies..."

# Check for essential dependencies
check_dependency "rustup"
check_dependency "cargo"
check_dependency "npm"
check_dependency "sudo"
check_dependency "apt-get"

echo "All dependencies are present. Installing LSPs..."

# Rust Analyzer
echo "Installing Rust Analyzer..."
rustup component add rust-analyzer

# Taplo, for TOML Files
echo "Installing Taplo (TOML LSP)..."
cargo install taplo-cli --locked --features lsp

# Javascript / Typescript
echo "Installing TypeScript LSP..."
npm i -g typescript typescript-language-server

# Bash
echo "Installing Bash LSP..."
npm i -g bash-language-server

# Python
echo "Installing Pyright (Python LSP)..."
npm i -g pyright

# Linters and Stuff
echo "Installing Emmet LSP..."
npm i -g @kozer/emmet-language-server
echo "Installing VSCode Language Servers (HTML, CSS, JSON, ESLint)..."
npm i -g vscode-langservers-extracted@v4.8.0
echo "Installing Biome..."
npm i -g @biomejs/biome
echo "Install Tailwind LSP..."
npm i -g @tailwindcss/language-server

# YAML
echo "Installing YAML LSP..."
npm i -g yaml-language-server@next

# Clangd for C/C++
echo "Installing Clangd (C/C++ LSP)..."
sudo apt-get update
sudo apt-get install clangd -y

echo "All LSPs have been successfully installed!"
