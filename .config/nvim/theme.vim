if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_Cs = "\<Esc>[4:3m"
  let &t_Ce = "\<Esc>[4:0m"
  set termguicolors
endif

if exists('+guicursor')
  set guicursor=n-v-c-sm:block,i-ci-ve:ver50-Cursor,r-cr-o:hor50
endif

set background=dark

" gruvbox configuration
let g:gruvbox_material_palette = 'material'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_transparent_background = 0
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_better_performance = 1

" set the colorscheme
colorscheme gruvbox-material
