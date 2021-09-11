local M = {}

M.declaration = function()
  vim.lsp.buf.declaration()
end

M.definition = function()
  vim.lsp.buf.definition()
end

M.hover = function()
  vim.lsp.buf.hover()
end

M.implementation = function()
  vim.lsp.buf.implementation()
end

M.signature_help = function()
  vim.lsp.buf.signature_help()
end

M.add_workspace_folder = function()
  vim.lsp.buf.add_workspace_folder()
end

M.remove_workspace_folder = function()
  vim.lsp.buf.remove_workspace_folder()
end

M.rename = function()
  vim.lsp.buf.rename()
end

M.references = function()
  vim.lsp.buf.references()
end

M.diagnostics = {
  show_line_diagnostics = function()
    vim.lsp.diagnostic.show_line_diagnostics()
  end,
  goto_prev = function()
    vim.lsp.diagnostic.goto_prev()
  end,
  goto_next = function()
    vim.lsp.diagnostic.goto_next()
  end,
  set_loclist = function()
    vim.lsp.diagnostic.set_loclist()
  end
}

return M
