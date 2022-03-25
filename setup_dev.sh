# Install binaries
HOMEBREW_PACKAGES=(
  llvm
  lua-language-server
  stylua
)

brew install @{HOMEBREW_PACKAGES}

# Install node based packages
NODE_PACKAGES=(
  typescript
  eslint
  prettier
  bash-language-server
  typescript-language-server
  vscode-langservers-extracted
  dockerfile-language-server-nodejs
  graphql-language-service-cli
  sql-language-server
  vim-language-server
  yaml-language-server
)

npm install -g ${}
