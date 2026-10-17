local SEVERITY_ICONS = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.INFO] = " ",
  [vim.diagnostic.severity.HINT] = " ",
}

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = {
    source = false,
    spacing = 2,
    prefix = function(diagnostic)
      return SEVERITY_ICONS[diagnostic.severity]
    end,
  },
  virtual_lines = false,
  signs = false,
  float = {
    scope = "cursor",
    header = false,
    focusable = false,
    -- border = "rounded",
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
