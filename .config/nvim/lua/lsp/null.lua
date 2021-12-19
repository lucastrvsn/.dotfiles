local on_attach = require "lsp/on_attach"

require("lspconfig")["null-ls"].setup {
  on_attach = on_attach,
}
