#!/bin/bash

# Strict Mode
set -euo pipefail
IFS=$'\n\t'

# -----------------------------------------------------------------------------
if ! command -v git &> /dev/null; then
  echo "GIT Missing"
  exit 1
fi

if ! command -v cargo &> /dev/null; then
  echo "Rust Missing"
  exit 1
fi

if ! command -v npm &> /dev/null; then
  echo "Node Missing"
  exit 1
fi
# -----------------------------------------------------------------------------

VERSION="25.01.1"
INSTALL_DIR="$HOME/helix"

echo "Installing Helix v$VERSION in '$INSTALL_DIR'..."

if [ -d "$INSTALL_DIR" ]; then
  cd $INSTALL_DIR
  git checkout master
  git pull
else
  git clone https://github.com/helix-editor/helix $INSTALL_DIR
  cd $INSTALL_DIR
fi
git checkout $VERSION
cargo install --path helix-term --locked

echo "Make sure HELIX_RUNTIME variable is set to the runtime"

echo "Install LSPs..."

# Rust Analyzer
rustup component add rust-analyzer

# Taplo, for TOML Files
cargo install taplo-cli --locked --features lsp

# Javascript / Typescript
npm install -g typescript typescript-language-server

# Bash
npm i -g bash-language-server

# Python
npm install -g pyright

# Linters and Stuff
npm install -g @kozer/emmet-language-server
npm i -g vscode-langservers-extracted@v4.8.0 # html, css, json, eslint

# YAML
npm i -g yaml-language-server@next

# Clangd for C/C++
sudo apt-get update
sudo apt-get install clangd -y
