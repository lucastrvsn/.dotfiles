local buf_map = require('utils').buf_map
local buf_option = require('utils').buf_option

local function on_attach(client)
  require('completion').on_attach(client)

  buf_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {
    noremap = true,
    silent = true
  }

  buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_map('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_map('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_map('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })<CR>', opts)
  buf_map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_map('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_map('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true, noremap = true })
  buf_map('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true, noremap = true })

  -- if client.resolved_capabilities.document_formatting then
  --   vim.api.nvim_command [[augroup Format]]
  --   vim.api.nvim_command [[autocmd! * <buffer>]]
  --   vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
  --   vim.api.nvim_command [[augroup END]]
  -- end
end

return on_attach
