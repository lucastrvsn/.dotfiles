require("catppuccin").setup {
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  transparent_background = false, -- disables setting the background color.
  show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  integrations = {
    cmp = true,
    gitsigns = true,
    telescope = true,
  },
}

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
