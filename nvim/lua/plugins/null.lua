local on_attach = require "lsp/on_attach"

require("null-ls").setup {
  sources = {
    -- diagnostics
    require("null-ls").builtins.diagnostics.eslint_d,

    -- formatters
    require("null-ls").builtins.formatting.eslint_d,
    require("null-ls").builtins.formatting.stylua,
  },
  on_attach = on_attach,
}
