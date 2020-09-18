local lsp = require'nvim_lsp'

local on_attach = function(client)
  require'diagnostic'.on_attach()
  require'completion'.on_attach()
end

-- css
lsp.cssls.setup{
  on_attach = on_attach
}

-- general diagnostic server
lsp.diagnosticls.setup{
  on_attach = on_attach
}

-- html
lsp.html.setup{
  on_attach = on_attach
}

-- json
lsp.jsonls.setup{
  on_attach = on_attach
}

-- rust
lsp.rls.setup{
  on_attach = on_attach
}

-- typescript
lsp.tsserver.setup{
  on_attach = on_attach
}

-- vim
lsp.vimls.setup{
  on_attach = on_attach
}

-- yaml
lsp.yamlls.setup{
  on_attach = on_attach
}
