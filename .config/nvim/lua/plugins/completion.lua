require("compe").setup {
  preselect = "disable",
  documentation = true,
  source = {
    buffer = {
      priority = 1,
      menu = "📁",
    },
    emoji = {
      priority = 1,
      menu = "",
    },
    nvim_lsp = {
      priority = 4,
      menu = "",
    },
    nvim_lua = {
      priority = 4,
      menu = "",
    },
    path = {
      priority = 2,
      menu = "📁",
    },
    treesitter = {
      priority = 3,
      menu = "",
    },
    spell = false,
    calc = false,
  },
}

vim.api.nvim_set_keymap(
  "i",
  "<Tab>",
  'pumvisible() ? "<C-n>" : "<Tab>"',
  { expr = true, noremap = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<S-Tab>",
  'pumvisible() ? "<C-p>" : "<S-Tab>"',
  { expr = true, noremap = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<C-Space>",
  "compe#complete()",
  { silent = true, expr = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<CR>",
  "compe#confirm('<CR>')",
  { silent = true, expr = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<C-e>",
  "compe#close('<C-e>')",
  { silent = true, expr = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<C-u>",
  "compe#scroll({'delta': +4 })",
  { silent = true, expr = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<C-u>",
  "compe#scroll({'delta': -4 })",
  { silent = true, expr = true }
)
