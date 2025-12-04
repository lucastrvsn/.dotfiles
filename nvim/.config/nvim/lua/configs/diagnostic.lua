vim.diagnostic.config {
  severity_sort = true,
  virtual_text = true,
  virtual_lines = false,
  float = {
    border = "shadow",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
}

vim.keymap.set("n", "<Leader>d", function()
  vim.diagnostic.open_float {
    scope = "cursor",
  }
end)
-- vim.keymap.set("n", "<Leader>dp", vim.diagnostic.prev)
-- vim.keymap.set("n", "<Leader>dn", vim.diagnostic.next)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)
