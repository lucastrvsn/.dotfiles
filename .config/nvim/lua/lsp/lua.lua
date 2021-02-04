local lsp_config = require('lspconfig')
local on_attach = require('lsp.on_attach')

lsp_config.sumneko_lua.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {
          "vim",
          "describe",
          "it",
          "before_each",
          "after_each",
          "awesome",
          "theme",
          "client"
        }
      }
    }
  }
})
