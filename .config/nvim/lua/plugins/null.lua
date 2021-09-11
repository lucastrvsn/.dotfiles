local null = require "null-ls"
local builtins = null.builtins

null.config {
  sources = {
    builtins.diagnostics.eslint_d,
    builtins.formatting.prettier,
  },
}

require("lspconfig")["null-ls"].setup {}
