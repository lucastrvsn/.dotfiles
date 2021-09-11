local M = {}

M.setup = function(opts)
  require('lsp/please/diagnostics').init()
end

return M
