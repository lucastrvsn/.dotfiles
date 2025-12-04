if vim.loader then
  vim.loader.enable()
end

vim.cmd.packadd "nohlsearch"

require "configs.options"
require "configs.mappings"
require "configs.autocmds"
require "configs.diagnostic"
require "configs.plugins"
