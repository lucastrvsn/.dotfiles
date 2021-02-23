require('opt')
require('settings')
require('mappings')

if vim.fn.exists('g:vscode') ~= 1 then
  require('theme')
  require('plugins')
end
