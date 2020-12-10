try
  call plug#begin()
  Plug 'airblade/vim-rooter' " change directory on vim open
  Plug 'asheq/close-buffers.vim' " close buffers
  Plug 'christoomey/vim-tmux-navigator' " tmux integration
  Plug 'editorconfig/editorconfig-vim' " support for editorconfig
  Plug 'easymotion/vim-easymotion' " cursor magic
  Plug 'farmergreg/vim-lastplace' " remember last cursor position
  Plug 'haya14busa/is.vim' " incsearch improved
  Plug 'cohama/lexima.vim' " auto close things
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf
  Plug 'junegunn/fzf.vim' " fzf integration with vim
  Plug 'justinmk/vim-dirvish' " fast netrw alternative
  Plug 'kristijanhusak/vim-dirvish-git' " git support for dirvish
  Plug 'lewis6991/gitsigns.nvim' " git gutter
  Plug 'matze/vim-move' " move lines up and down
  Plug 'neovim/nvim-lspconfig' " neovim lsp common configs
  Plug 'nvim-lua/completion-nvim' " completion using lsp
  Plug 'nvim-lua/plenary.nvim' " utils nvim
  Plug 'nvim-treesitter/nvim-treesitter' " nvim treesitter
  Plug 'nvim-treesitter/nvim-treesitter-refactor' " nice treesitter refactor
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " code formatter
  Plug 'psliwka/vim-smoothie' " smooth scroll
  Plug 'sainnhe/gruvbox-material' " theme
  " Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' } " virtual text colors
  Plug 'tpope/vim-eunuch' " unix commands inside vim
  Plug 'tpope/vim-fugitive' " git integration
  Plug 'tpope/vim-surround' " change surround characters
  Plug 'tyru/caw.vim' " comment plugin
  Plug 'unblevable/quick-scope' " improve t and f keys
  call plug#end()
catch
  echom 'vim-plug not installed'
endtry

" completion-nvim {{{
  let g:completion_confirm_key = ""
  let g:completion_enable_auto_popup = 1
  let g:completion_enable_auto_hover = 1
  let g:completion_matching_smart_case = 1
  let g:completion_auto_change_source = 1
  let g:completion_matching_strategy_list = ['fuzzy', 'substring', 'exact', 'all']

  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <CR>  pumvisible() ? complete_info()["selected"] != "-1" ?
    \ "\<Plug>(completion_confirm_completion)"  :
    \ "\<c-e>\<CR>" : "\<CR>"
" }}}

" dirvish {{{
  let dirvish_mode = ':sort ,^.*/,'

  command! -nargs=? -complete=dir Explore Dirvish <args>
  command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
  command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
" }}}

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

" prettier {{{
  let g:prettier#exec_cmd_async = 1
  let g:prettier#config#single_quote = 'true'
  let g:prettier#config#trailing_comma = 'none'
  let g:prettier#autoformat = 0

  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
" }}}

" fzf {{{
  let g:fzf_action = {
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  let g:fzf_layout = { 'down': '~60%' }
  let g:fzf_preview_window = 'right:60%:border:sharp'
  let $FZF_DEFAULT_COMMAND="rg --files --hidden --smart-case"
  let $FZF_DEFAULT_OPTS="--inline-info --prompt=ᐳ --pointer=ᐅ --marker=ᐅ"

  nnoremap <C-p>     :Files<CR>
  nnoremap <leader>w :Windows<CR>
  nnoremap <leader>g :Rg<CR>
  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>h :History<CR>

  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
    \| autocmd BufLeave <buffer> set laststatus=2 ruler number relativenumber
" }}}

" vim-rooter {{{
  let g:rooter_cd_cmd = 'lcd'
  let g:rooter_silent_chdir = 0
  let g:rooter_change_directory_for_non_project_files = 'current'
" }}}
