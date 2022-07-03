local lsp_config = require('lspconfig')
local on_attach = require('lsp/on_attach')

lsp_config.cssls.setup({
  filetypes = { 'css', 'sass', 'scss' },
  settings = {
    css = {
      validate = true
    },
    sass = {
      validate = true
    },
    scss = {
      validate = true
    }
  },
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end
})
