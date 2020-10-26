local lsp = require'nvim_lsp'

local on_attach = function(client)
  require'diagnostic'.on_attach(client)
  require'completion'.on_attach(client)

  local options = {
    noremap = true,
    silent = true
  }

  vim.api.nvim_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
  vim.api.nvim_set_keymap('n', 'K',     '<cmd>lua vim.lsp.buf.hover()<CR>', options)
  vim.api.nvim_set_keymap('n', 'gD',    '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
  vim.api.nvim_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
  vim.api.nvim_set_keymap('n', '1gD',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
  vim.api.nvim_set_keymap('n', 'gr',    '<cmd>lua vim.lsp.buf.references()<CR>', options)
  vim.api.nvim_set_keymap('n', 'g0',    '<cmd>lua vim.lsp.buf.document_symbol()<CR>', options)
  vim.api.nvim_set_keymap('n', 'gW',    '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', options)
  vim.api.nvim_set_keymap('n', 'gd',    '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
  vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')
end

-- bash
lsp.bashls.setup{
  on_attach = on_attach
}

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

-- lua
lsp.sumneko_lua.setup{
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

