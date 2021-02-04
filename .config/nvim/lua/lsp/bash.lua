local lsp_config = require('lspconfig')
local on_attach = require('lsp.on_attach')

lsp_config.bashls.setup({
  on_attach = on_attach
})
