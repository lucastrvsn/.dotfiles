local map = vim.api.nvim_set_keymap

require("nnn").setup {
  replace_netrw = "explorer",
  windownav = {
    left = "<C-l>",
    right = "<C-h>",
  },
}

map("n", "-", "<CMD>NnnExplorer %:p:h<CR>", { noremap = true, silent = true })
