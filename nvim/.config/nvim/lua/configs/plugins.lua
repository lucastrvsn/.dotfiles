local PACKAGE_PATH = vim.fn.stdpath "data" .. "/site"
local MINI_PATH = PACKAGE_PATH .. "/pack/deps/start/mini.nvim"
local PLUGINS_PATH = vim.fn.stdpath "config" .. "/lua/plugins"

if not vim.uv.fs_stat(MINI_PATH) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'

  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    MINI_PATH,
  }

  vim.cmd "packadd mini.nvim | helptags ALL"
  vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

require("mini.deps").setup {
  path = {
    package = PACKAGE_PATH,
  },
}

local handle = vim.uv.fs_scandir(PLUGINS_PATH)
local filename, _ = vim.uv.fs_scandir_next(handle)

while filename ~= nil do
  require("plugins." .. filename:match "[%a_]+")

  filename, _ = vim.uv.fs_scandir_next(handle)
end
