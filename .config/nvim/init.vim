" {{{ Plugins
call plug#begin()

Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'haya14busa/incsearch.vim'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-commentary'
Plug 'matze/vim-move'
Plug 'danilamihailov/beacon.nvim'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Themes
Plug 'morhetz/gruvbox'
Plug 'hardcoreplayers/oceanic-material'

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
  set updatetime=300

  " Command history
  set history=100

  " Always show cursor
  set ruler

  " Show incomplete commands
  set showcmd

  " Set magic by default
  set magic

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
  set list listchars=tab:\ \ ,trail:·

  " Get rid of the delay when pressing O (for example)
  " http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
  set timeout timeoutlen=1000 ttimeoutlen=100

  " Always show status bar
  set laststatus=2

  " Set wildmenu
  set wildmenu
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,**/node_modules/**
  set path+=**

  " Hide the toolbar (gui)
  set guioptions-=T

  " UTF encoding
  set encoding=utf-8
  set fileencoding=utf-8

  " Autoload files that have changed outside of vim
  set autoread

  " Use system clipboard
  " http://stackoverflow.com/questions/8134647/copy-and-paste-in-vim-via-keyboard-between-different-mac-terminals
  set clipboard+=unnamed

  " Better splits (new windows appear below and to the right)
  set splitbelow
  set splitright

  " Ensure Vim doesn't beep at you every time you make a mistype
  set visualbell
  set noerrorbells
  set t_vb=
  set tm=500

  " Visual autocomplete for command menu (e.g. :e ~/path/to/file)
  set wildmenu

  " redraw only when we need to (i.e. don't redraw when executing a macro)
  set lazyredraw

  " highlight a matching [{()}] when cursor is placed on start/end character
  set showmatch

  " Always highlight column 80 so it's easier to see where
  " cutoff appears on longer screens
  set colorcolumn=80
" }}}

" {{{ Plugin settings
  " Coc {{{
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

    autocmd CursorHold * silent call CocActionAsync('highlight')
  " }}}

  " Prettier {{{
    let g:prettier#config#single_quote = "true"
    let g:prettier#config#trailing_comma = "none"
    let g:prettier#autoformat = 0

    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
  " }}}

  " incsearch
  let g:incsearch#auto_nohlsearch = 1

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

  " FZF {{{
    let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'highlight': 'Todo', 'border': 'rounded' } }
  " }}}

  " Lightline {{{
    let g:lightline = {}
    let g:lightline.colorscheme = 'gruvbox'
  " }}}

  " Startify {{{
    " Don't change to directory when selecting a file
    let g:startify_files_number = 5
    let g:startify_change_to_dir = 0
    let g:startify_custom_header = [ ]
    let g:startify_relative_path = 1
    let g:startify_use_env = 1

    " Custom startup list, only show MRU from current directory/project
    let g:startify_lists = [
    \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
    \  { 'type': function('helpers#listcommits'), 'header': [ 'Recent Commits' ] },
    \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
    \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
    \  { 'type': 'commands',  'header': [ 'Commands' ]       },
    \ ]

    let g:startify_commands = [
    \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
    \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
    \ ]

    let g:startify_bookmarks = [
        \ { 'c': '~/.config/nvim/init.vim' },
        \ { 'g': '~/.gitconfig' },
        \ { 'z': '~/.zshrc' }
    \ ]

    autocmd User Startified setlocal cursorline
    nmap <leader>st :Startify<cr>
  " }}}

  " ctrlspace
  let g:CtrlSpaceDefaultMappingKey = "<C-space> "

  " vim-rotter
  let g:rooter_change_directory_for_non_project_files = 'current'
" }}}

" Mappings {{{
  let mapleader = "\<Space>"

  " ******
  " general
  " ******
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

  if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    nnoremap <C-b>c :tabnew +terminal<CR>
    tnoremap <C-b>c <C-\><C-n>:tabnew +terminal<CR>

    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
  endif

  " ******
  " coc
  " ******
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <Leader>rn <Plug>(coc-rename)
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  " use <tab> for trigger completion and navigate to the next complete item
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

  " use <c-space>for trigger completion
  inoremap <silent><expr> <c-space> coc#refresh()
  inoremap <silent><expr> <NUL> coc#refresh()
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " ******
  " fzf
  " ******
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

  " ******
  " ctrlspace
  " ******
  nnoremap <leader>t :CtrlSpace l<CR>

  " ******
  " commentary
  " ******
  map <C-_> <Plug>Commentary<CR>

  " ******
  " incsearch
  " ******
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)

  " ******
  " prettier
  " ******
  nmap <Leader>p <Plug>(Prettier)
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
  colorscheme gruvbox
  hi EndOfBuffer guifg=bg
" }}}
