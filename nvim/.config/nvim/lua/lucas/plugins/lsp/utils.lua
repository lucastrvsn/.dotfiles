local M = {}

function M.get_root_dirs()
  local dirs = {}

  for _, client in pairs(vim.lsp.get_active_clients()) do
    table.insert(dirs, client.config.root_dir)
  end

  return dirs
end

return M
