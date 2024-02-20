vim.diagnostic.config {
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
}

vim.keymap.set("n", "<Leader>d", function()
  vim.diagnostic.open_float {
    scope = "cursor",
    source = "if_many",
  }
end)
vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)
