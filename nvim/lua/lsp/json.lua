local lsp_config = require('lspconfig')
local on_attach = require('lsp/on_attach')

lsp_config.jsonls.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    on_attach(client)
  end
})
