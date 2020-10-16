try
  call plug#begin()
    Plug 'unblevable/quick-scope' " improve t and f keys
    Plug 'andymass/vim-matchup' " match more vim words
    Plug 'farmergreg/vim-lastplace' " remember last cursor position
    Plug 'haya14busa/is.vim' " incsearch improved
    Plug 'machakann/vim-highlightedyank' " highlight yanked text
    Plug 'matze/vim-move' " move lines up and down
    Plug 'mg979/vim-visual-multi', { 'branch': 'master' } " multi cursors
    Plug 'tpope/vim-surround' " change surround characters
    Plug 'tyru/caw.vim' " comment plugin
  call plug#end()
catch
  echom 'vim-plug not installed'
endtry

" quick-scope {{{
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
  augroup END
" }}}
