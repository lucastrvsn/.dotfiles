local gitsigns = require "gitsigns"

gitsigns.setup {
  signs = {
    add = {
      text = "▎",
    },
    change = {
      text = "▎",
    },
    delete = {
      text = "▁",
    },
    topdelete = {
      text = "▔",
    },
    changedelete = {
      text = "〜",
    },
    untracked = {
      text = "┆",
    },
  },
  on_attach = function(buffer)
    vim.keymap.set("n", "<Leader>gb", function()
      gitsigns.blame_line { full = false }
    end, {
      buffer = buffer,
    })
    vim.keymap.set("n", "<Leader>gB", function()
      gitsigns.blame_line { full = true }
    end, {
      buffer = buffer,
    })
  end,
}
