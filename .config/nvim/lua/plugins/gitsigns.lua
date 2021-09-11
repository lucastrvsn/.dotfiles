require("gitsigns").setup {
  signs = {
    add = { hl = "DiffAdd", text = "▎" },
    change = { hl = "DiffChange", text = "▎" },
    delete = { hl = "DiffDelete", text = "▁" },
    topdelete = { hl = "DiffDelete", text = "▔" },
    changedelete = { hl = "DiffChange", text = "〜" },
  },
}
