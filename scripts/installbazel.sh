#!/bin/bash

if ! command -v go &> /dev/null; then
  echo "Go is not installed. Please install go first"
  exit 1
fi

if ! command -v cargo &> /dev/null; then
  echo "Cargo is not installed. Please install RustTools first"
  exit 1
fi

# Install Bazelisk
go install github.com/bazelbuild/bazelisk@latest
sudo ln -sf $(go env GOPATH)/bin/bazelisk /usr/local/bin/bazel

# Install buildifier (formatter/linter)
go install github.com/bazelbuild/buildtools/buildifier@latest

# Install
go install github.com/bazelbuild/buildtools/buildozer@latest

# Install
go install github.com/bazelbuild/buildtools/unused_deps@latest

wget https://github.com/cameron-martin/bazel-lsp/releases/download/v0.6.4/bazel-lsp-0.6.4-linux-amd64
chmod +x bazel-lsp-0.6.4-linux-amd64
sudo mv bazel-lsp-0.6.4-linux-amd64 /usr/local/bin/bazel-lsp
