#! /bin/sh

NPM_PACKAGES=(
  "diagnostic-languageserver"
  "vim-language-server"
  "sql-language-server"
  "typescript-language-server"
  "vscode-json-languageserver"
  "vscode-css-languageserver-bin"
  "vscode-html-languageserver-bin"
  "bash-language-server"
  "typescript"
  "eslint"
  "prettier"
)

GO_PACKAGES=(
  "github.com/mattn/efm-langserver"
)

echo "installing packages..."
npm install --global ${NPM_PACKAGES[@]}
go get ${GO_PACKAGES[@]}
echo "🎉 installation completed."

