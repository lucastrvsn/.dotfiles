require('lspconfig').rome.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    require('lsp/on_attach')(client)
  end
})
