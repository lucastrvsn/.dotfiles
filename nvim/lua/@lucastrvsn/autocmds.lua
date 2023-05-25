-- highlight text on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Highlight the yanked lines",
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 200,
    }
  end,
})
