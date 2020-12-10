try
  call plug#begin()
  Plug 'easymotion/vim-easymotion' " cursor magic
  Plug 'haya14busa/is.vim' " incsearch improved
  Plug 'matze/vim-move' " move lines up and down
  Plug 'tpope/vim-eunuch' " unix commands inside vim
  Plug 'tpope/vim-surround' " change surround characters
  Plug 'tyru/caw.vim' " comment plugin
  Plug 'unblevable/quick-scope' " improve t and f keys
  call plug#end()
catch
  echom 'vim-plug not installed'
endtry

" easymotion {{{
  let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
  let g:EasyMotion_smartcase = 1

  map <Leader>f <Plug>(easymotion-bd-f)
  nmap <Leader>f <Plug>(easymotion-overwin-f)
  map <Leader>l <Plug>(easymotion-bd-jk)
  nmap <Leader>l <Plug>(easymotion-overwin-line)
  map <Leader><Leader> <Plug>(easymotion-bd-w)
  nmap <Leader><Leader> <Plug>(easymotion-overwin-w)
" }}}

" quick-scope {{{
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
  augroup END
" }}}
