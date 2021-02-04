local apply_colorscheme = require('utils').apply_colorscheme
local apply_globals = require('utils').apply_globals

apply_globals({
  gruvbox_material_palette = 'material',
  gruvbox_material_background = 'soft',
  gruvbox_material_enable_italic = false,
  gruvbox_material_disable_italic_comment = true,
  gruvbox_material_transparent_background = false,
  gruvbox_material_diagnostic_line_highlight = true,
  gruvbox_material_better_performance = true
})

apply_colorscheme('gruvbox-material', 'dark')

