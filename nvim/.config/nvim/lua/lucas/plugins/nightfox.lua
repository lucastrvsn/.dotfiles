require("nightfox").setup {
  options = {
    terminal_colors = true,
    inverse = {
      match_paren = false,
      visual = true,
      search = false,
    },
    modules = {
      cmp = true,
      gitsigns = true,
      telescope = true,
    },
  },
}

vim.cmd.colorscheme "carbonfox"
