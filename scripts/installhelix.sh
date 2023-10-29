#!/bin/bash

VERSION="32.10"

echo "Installing Helix v$VERSION..."

git clone https://github.com/helix-editor/helix
cd helix
git checkout 23.10
cargo install --path helix-term --locked

echo "Make sure HELIX_RUNTIME variable is set to the runtime"
