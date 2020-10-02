local lsp = require'nvim_lsp'

local on_attach = function(client)
  require'diagnostic'.on_attach(client)
  require'completion'.on_attach(client)
end

-- css
lsp.cssls.setup{
  on_attach = on_attach
}

-- general diagnostic server
lsp.diagnosticls.setup{
  on_attach = on_attach,
  filetypes={ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  init_options = {
    linters = {
      eslint = {
        command = './node_modules/.bin/eslint',
        rootPatterns = { '.git' },
        debounce = 100,
        args = {
          '--stdin',
          '--stdin-filename',
          '%filepath',
          '--format',
          'json'
        },
        sourceName = 'eslint',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning',
        },
      },
    },
    filetypes = {
      javascript = 'eslint',
      typescript = 'eslint',
      javascriptreact = 'eslint',
      typescriptreact = 'eslint'
    },
    formatters = {
      prettier = {
        command = './node_modules/.bin/prettier',
        args = { '--stdin-filepath', '%filepath', '--single-quote', '--print-width 120' }
      }
    },
    formatFiletypes = {
      javascript = 'prettier',
      typescript = 'prettier',
      javascriptreact = 'prettier',
      typescriptreact = 'prettier'
    },
  }
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
