try
  call plug#begin()
  Plug 'airblade/vim-rooter' " change directory on vim open
  Plug 'christoomey/vim-tmux-navigator' " tmux integration
  Plug 'farmergreg/vim-lastplace' " remember last cursor position
  Plug 'haya14busa/is.vim' " incsearch improved
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf
  Plug 'junegunn/fzf.vim' " fzf integration with vim
  Plug 'justinmk/vim-dirvish' " fast netrw alternative
  Plug 'kristijanhusak/vim-dirvish-git' " git support for dirvish
  Plug 'lewis6991/gitsigns.nvim' " git gutter
  Plug 'matze/vim-move' " move lines up and down
  Plug 'mhartington/formatter.nvim' " formatters for neovim
  Plug 'neovim/nvim-lspconfig' " neovim lsp common configs
  Plug 'nvim-lua/completion-nvim' " completion using lsp
  Plug 'nvim-lua/plenary.nvim' " utils nvim
  Plug 'nvim-treesitter/nvim-treesitter' " nvim treesitter
  Plug 'nvim-treesitter/nvim-treesitter-refactor' " nice treesitter refactor
  Plug 'psliwka/vim-smoothie' " smooth scroll
  Plug 'sainnhe/gruvbox-material' " gruvbox colorscheme
  Plug 'pineapplegiant/spaceduck', { 'branch': 'main' } " spaceduck colorscheme
  Plug 'itchyny/lightline.vim' " statusbar
  Plug 'tpope/vim-fugitive' " git integration
  Plug 'tpope/vim-surround' " change surround characters
  Plug 'tyru/caw.vim' " comment plugin
  call plug#end()
catch
  echom 'vim-plug not installed'
endtry

" dirvish {{{
  let dirvish_mode = ':sort ,^.*/,'

  command! -nargs=? -complete=dir Explore Dirvish <args>
  command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
  command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
" }}}

" lightline {{{
  let g:lightline = {}
  let g:lightline.colorscheme = 'gruvbox_material'
" }}}

" fzf {{{
  let g:fzf_action = {
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  let g:fzf_layout = { 'down': '~30%' }
  let g:fzf_preview_window = 'right:60%:border:sharp'
  let $FZF_DEFAULT_COMMAND="rg --files --hidden --smart-case"
  let $FZF_DEFAULT_OPTS="--inline-info --prompt=ᐳ --pointer=ᐅ --marker=ᐅ"

  nnoremap <C-p>     :Files<CR>
  nnoremap <leader>w :Windows<CR>
  nnoremap <leader>g :Rg<CR>
  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>h :History<CR>

  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noruler nonumber norelativenumber
    \| autocmd BufLeave <buffer> set laststatus=2 ruler number relativenumber
" }}}

" vim-rooter {{{
  let g:rooter_cd_cmd = 'lcd'
  let g:rooter_silent_chdir = 0
  let g:rooter_change_directory_for_non_project_files = 'current'
" }}}

set concealcursor=nc
set conceallevel=1
let leading_space_char="·"

call matchadd('Conceal', '\%(^\s*\)\@<= ', 0, -1, { 'conceal': leading_space_char })
highlight Conceal blend=8
" execute 'syntax match IndentLineLeadingSpace /\%(^\s*\)\@<= / conceal cchar=' . leading_space_char
