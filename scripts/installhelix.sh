#!/bin/bash

# Strict Mode
set -euo pipefail
IFS=$'\n\t'

# ----------------------------------------------------------------

VERSION="32.10"

echo "Installing Helix v$VERSION..."

git clone https://github.com/helix-editor/helix
cd helix
git checkout 23.10
cargo install --path helix-term --locked

echo "Make sure HELIX_RUNTIME variable is set to the runtime"

echo "Install LSPs..."

# Taplo, for TOML Files
cargo install taplo-cli --locked --features lsp

# Javascript / Typescript
npm install -g typescript typescript-language-server

# Bash
npm i -g bash-language-server

# Python
npm install --location=global

# Linters and Stuff
npm install -g @kozer/emmet-language-server
npm i -g vscode-langservers-extracted # html, css, json, eslint
