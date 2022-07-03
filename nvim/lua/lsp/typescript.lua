local lsp_config = require('lspconfig')

lsp_config.tsserver.setup({
  capabilities = require("lsp/capabilities"),
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    require("lsp/on_attach")(client)
  end
})
