#!/bin/bash

if ! command -v go &> /dev/null; then
  echo "Go is not installed. Please install go first"
  exit 1
fi

# LSP
go install golang.org/x/tools/gopls@latest
# Debugger
go install github.com/go-delve/delve/cmd/dlv@latest
# Formatter
go install golang.org/x/tools/cmd/goimports@latest
# Linter LSP
go install github.com/nametake/golangci-lint-langserver@latest
# Linter CLI
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Buf CLI (protobuf)
go install github.com/bufbuild/buf/cmd/buf@v1.54.0
