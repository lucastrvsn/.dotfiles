vim.opt.termguicolors = true
vim.opt.background = "dark"

-- kikwis options
vim.g.kikwis_pallete = "lopsa"

-- gruvbox-material options
vim.g.gruvbox_material_background = "soft"

-- try to set the colorscheme
vim.cmd[[
  try
    colorscheme gruvbox-material
  catch /^Vim\%((\a\+)\)\=:E185/
    " TODO: handle error
  endtry
]]
