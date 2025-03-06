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
