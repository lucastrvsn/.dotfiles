local lsp_config = require('lspconfig')
local on_attach = require('lsp.on_attach')

lsp_config.tsserver.setup({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end
})
