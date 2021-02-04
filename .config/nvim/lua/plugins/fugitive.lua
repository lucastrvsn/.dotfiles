local options = {
  noremap = true
}

vim.api.nvim_set_keymap('n', '<Leader>ga', '<cmd>Gwrite<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gc', '<cmd>Gcommit<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gsh', '<cmd>Gpush<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gll', '<cmd>Gpull<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gs', '<cmd>Gstatus<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gb', '<cmd>Gstatus<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gd', '<cmd>Gvdiff<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gr', '<cmd>Gremove<CR>', options)
