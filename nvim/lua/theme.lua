vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.guicursor = {
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

-- kikwis colorscheme options
vim.g.kikwis_pallete = "lopsa"

-- try to set the colorscheme
vim.cmd[[
  try
    colorscheme gruvbox-material
  catch /^Vim\%((\a\+)\)\=:E185/
    " TODO: handle error
  endtry
]]
