" github.com/lucastrvsn

" {{{ Plugins
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'haya14busa/incsearch.vim'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-commentary'
Plug 'matze/vim-move'
Plug 'danilamihailov/beacon.nvim'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'Yggdroot/indentLine'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'

call plug#end()
" }}}

" General {{{
  " Switch syntax highlighting on, when the terminal has colors
  syntax on

  " Use vim, not vi api
  set nocompatible

  " Use mouse
  set mouse=a

  " No backup files
  set nobackup

  " No write backup
  set nowritebackup

  " No swap file
  set noswapfile

  " Change update time
  set updatetime=100

  " Set magic by default
  set magic

  " Reduce vim messages
  set showcmd
  set ruler

  " Incremental searching (search as you type)
  set incsearch

  " Highlight search matches
  set hlsearch

  " Ignore case in search
  set smartcase

  " Make sure any searches /searchPhrase doesn't need the \c escape character
  set ignorecase

  " A buffer is marked as ‘hidden’ if it has unsaved changes, and it is not currently loaded in a window
  " if you try and quit Vim while there are hidden buffers, you will raise an error:
  " E162: No write since last change for buffer “a.txt”
  set hidden

  " Turn word wrap off
  set nowrap

  " Allow backspace to delete end of line, indent and start of line characters
  set backspace=indent,eol,start

  " Convert tabs to spaces
  set expandtab
  set smarttab

  " Set tab size in spaces (this is for manual indenting)
  set tabstop=2

  " The number of spaces inserted for a tab (used for auto indenting)
  set softtabstop=2
  set shiftwidth=2

  " Turn on line numbers
  set number
  set relativenumber

  " Improve terminal colors
  set termguicolors

  " Highlight tailing whitespace
  " See issue: https://github.com/Integralist/ProVim/issues/4
  set list listchars=tab:·\ ,trail:·

  " Get rid of the delay when pressing O (for example)
  " http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
  set timeout
  set timeoutlen=1000
  set ttimeoutlen=100

  " Always show status bar
  set laststatus=2
  set showtabline=0

  " Set wildmenu
  set wildmenu
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,**/node_modules/**
  set path+=**

  " UTF encoding
  set encoding=utf-8
  set fileencoding=utf-8

  " Autoload files that have changed outside of vim
  set autoread

  " Better splits (new windows appear below and to the right)
  set splitbelow
  set splitright

  " Ensure Vim doesn't beep at you every time you make a mistype
  set visualbell
  set noerrorbells

  " highlight a matching [{()}] when cursor is placed on start/end character
  set showmatch

  " Always highlight column 80 so it's easier to see where
  " cutoff appears on longer screens
  set colorcolumn=80
" " }}}

" Mappings {{{
  nnoremap <Space> <Nop>
  let mapleader = "\<Space>"

  " moving up and down the right way
  nnoremap <silent> j gj
  nnoremap <silent> k gk
  nnoremap <silent> ^ g^
  nnoremap <silent> $ g$

  " remove arrow keys mappings
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exec 'noremap' key '<Nop>'
    exec 'inoremap' key '<Nop>'
    exec 'cnoremap' key '<Nop>'
  endfor

  " keep visual selection when indenting
  vmap < <gv
  vmap > >gv

  " neovim terminal
  if has('nvim')
    au TermOpen * tnoremap <Esc> <C-\><C-n>
    au FileType fzf tunmap <Esc>
    nnoremap <Leader>c :tabnew +terminal<CR>
    tnoremap <Leader>c <C-\><C-n>:tabnew +terminal<CR>

    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
  endif
" }}}

" {{{ Plugin settings
  " nerdtree {{{
    let g:NERDTreeWinPos = "left"
    let g:NERDTreeWinSize = 28

    map <leader>n :NERDTreeToggle<CR>
  " }}}

  " coc {{{
    let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-cssmodules',
      \ 'coc-browser',
      \ 'coc-highlight',
      \ 'coc-git',
      \ 'coc-markdownlint',
      \ 'coc-pairs',
      \ 'coc-rls',
      \ 'coc-yaml',
      \ 'coc-yank'
    \]

    function! s:show_documentation()
      if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h ' . expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " use <tab> for trigger completion and navigate to the next complete item
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    nmap <silent> gd          <Plug>(coc-definition)
    nmap <silent> gi          <Plug>(coc-implementation)
    nmap <silent> gr          <Plug>(coc-references)
    nmap <Leader>rn           <Plug>(coc-rename)

    nnoremap <silent> K :call <SID>show_documentation()<CR>
    inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
    inoremap <silent><expr> <c-space> coc#refresh()
    inoremap <silent><expr> <NUL> coc#refresh()
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    autocmd CursorHold * silent call CocActionAsync('highlight')
  " }}}

  " lightline {{{
    let g:lightline = {}
    let g:lightline.colorscheme = 'ayu_mirage'
  " }}}

  " Prettier {{{
    let g:prettier#config#single_quote = "true"
    let g:prettier#config#trailing_comma = "none"
    let g:prettier#autoformat = 0

    nmap <Leader>p <Plug>(Prettier)

    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
  " }}}

  " incsearch {{{
    let g:incsearch#auto_nohlsearch = 1

    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
    map n  <Plug>(incsearch-nohl-n)
    map N  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
    map g* <Plug>(incsearch-nohl-g*)
    map g# <Plug>(incsearch-nohl-g#)
  " }}}

  " fzf {{{
    let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'highlight': 'Todo', 'border': 'rounded' } }

    function! FzfOmniFiles()
      if fugitive#head() != ''
        :GitFiles
      else
        :Files
      endif
    endfunction

    nnoremap <C-p> :call FzfOmniFiles()<CR>
    nnoremap <leader>fi       :Files<CR>
    nnoremap <leader>C        :Colors<CR>
    nnoremap <leader><CR>     :Buffers<CR>
    nnoremap <leader>fl       :Lines<CR>
    nnoremap <leader>m        :History<CR>
  " }}}

  " indentLine {{{
    let g:indentLine_enabled = 0 " disable vertical lines
    let g:indentLine_leadingSpaceEnabled = 1 " enable leading spaces
    let g:indentLine_leadingSpaceChar = '·'
  " }}}

  " multilinecursor {{{
    let g:multi_cursor_use_default_mapping = 0
    let g:multi_cursor_start_word_key      = 'gb'
    let g:multi_cursor_select_all_word_key = '<A-n>'
    let g:multi_cursor_start_key           = 'g<C-n>'
    let g:multi_cursor_select_all_key      = 'g<A-n>'
    let g:multi_cursor_next_key            = 'gb'
    let g:multi_cursor_prev_key            = '<C-p>'
    let g:multi_cursor_skip_key            = '<C-x>'
    let g:multi_cursor_quit_key            = '<Esc>'
  " }}}

  " ctrlspace {{{
    let g:CtrlSpaceDefaultMappingKey = "<C-space> "

    nnoremap <leader>t :CtrlSpace l<CR>
  " }}}

  " vim-commentary {{{
    map <C-_> <Plug>Commentary<CR>
  " }}}

  " vim-rooter {{{
    let g:rooter_silent_chdir = 1
    let g:rooter_change_directory_for_non_project_files = 'current'
  " }}}
" }}}

" {{{ Autocommands
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Scroll offset on current window
  autocmd VimEnter,WinEnter * let &scrolloff = winheight(0) / 4
" }}}

" {{{ Theme
  set background=dark
  let ayucolor="mirage"
  colorscheme ayu

  hi EndOfBuffer guifg=bg
" }}}
