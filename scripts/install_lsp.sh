#! /bin/sh

NPM_PACKAGES=(
  "vim-language-server"
  "sql-language-server"
  "typescript-language-server"
  "vscode-json-languageserver"
  "vscode-css-languageserver-bin"
  "vscode-html-languageserver-bin"
  "bash-language-server"
)

GO_PACKAGES=(
  "github.com/mattn/efm-langserver"
)

echo "installing language servers..."
npm install --global ${NPM_PACKAGES[@]}
go get ${GO_PACKAGES[@]}
echo "✅ LSP installation successful."

NPM_UTILS_PACKAGES=(
  "typescript"
  "eslint"
  "prettier"
)

echo "installing utilities"
npm install --global ${NPM_UTILS_PACKAGES[@]}
echo "✅ utilities installtation successful."

echo "🎉 installation completed."
