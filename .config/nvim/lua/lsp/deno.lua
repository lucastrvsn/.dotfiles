require('lspconfig').denols.setup({
  cmd = { 'deno', 'lsp' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx'
  },
  init_options = {
    enable = true,
    lint = true,
    unstable = false
  },
  on_attach = function(client)
    -- client.resolved_capabilities.document_formatting = false
    require('lsp/on_attach')(client)
  end
})
