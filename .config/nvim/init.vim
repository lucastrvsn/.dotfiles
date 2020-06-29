" {{{ Plugins
call plug#begin()

Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'haya14busa/incsearch.vim'
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

" Settings {{{
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
set t_Co=256

" Highlight tailing whitespace
" See issue: https://github.com/Integralist/ProVim/issues/4
set list listchars=tab:\ \ ,trail:·

" Get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=1000 ttimeoutlen=100

" Always show status bar
set laststatus=2

" Set the status line to something useful
function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  endif
  return ''
endfunction

function! GitInfo()
  if fugitive#head() != ''
    return '  '.fugitive#head().' '
  endif
  return ''
endfunction

function! GetMode()
  if mode() == "\<C-v>"
    return 'vb'
  endif
  return mode()
endfunction

autocmd ColorScheme * highlight link Mode1 StatusLine
autocmd ColorScheme * highlight link Mode2 DiffChange
autocmd ColorScheme * highlight link Mode3 Search
autocmd ColorScheme * highlight link Mode4 DiffDelete
autocmd ColorScheme * highlight link Mode5 DiffDelete
autocmd ColorScheme * highlight link StatuslineBackground StatusLineNC
autocmd ColorScheme * highlight link StatuslineGitBranch Number

set noshowmode
set statusline=
set statusline+=%#Mode1#%{GetMode()=='c'?'\ \ Command\ ':''}
set statusline+=%#Mode1#%{GetMode()=='n'?'\ \ Normal\ ':''}
set statusline+=%#Mode2#%{GetMode()=='i'?'\ \ Insert\ ':''}
set statusline+=%#Mode3#%{GetMode()==#'v'?'\ \ Visual\ ':''}
set statusline+=%#Mode3#%{GetMode()==#'V'?'\ \ V·Line\ ':''}
set statusline+=%#Mode3#%{GetMode()=='vb'?'\ \ V·Block\ ':''}
set statusline+=%#Mode4#%{GetMode()=='R'?'\ \ Replace\ ':''}
set statusline+=%#Mode4#%{GetMode()=='Rv'?'\ \ V·Replace\ ':''}
set statusline+=%#StatusLineNC#
set statusline+=\ %f\ 
set statusline+=%{ReadOnly()}
set statusline+=%= " right side
set statusline+=%#StatusLineGitBranch#%{GitInfo()}
set statusline+=%#StatusLineNC#
set statusline+=\ %{tolower(&filetype)}
set statusline+=\ %p%%\ %l:%c\ 

" Set wildmenu
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,**/node_modules/**
set path+=**

" Hide the toolbar
set guioptions-=T

" UTF encoding
set encoding=utf-8
set fileencoding=utf-8

" Autoload files that have changed outside of vim
set autoread

" Use system clipboard
" http://stackoverflow.com/questions/8134647/copy-and-paste-in-vim-via-keyboard-between-different-mac-terminals
set clipboard+=unnamed

" Don't show intro
set shortmess+=I

" Better splits (new windows appear below and to the right)
set splitbelow
set splitright

" Ensure Vim doesn't beep at you every time you make a mistype
set visualbell

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
" coc
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

" prettier
let g:prettier#config#single_quote = "true"
let g:prettier#config#trailing_comma = "none"
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

" incsearch
let g:incsearch#auto_nohlsearch = 1

" multilinecursor
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = 'gb'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = 'gb'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'highlight': 'Todo', 'border': 'rounded' } }

" ctrlspace
let g:CtrlSpaceDefaultMappingKey = "<C-space> "

" vim-rotter
let g:rooter_change_directory_for_non_project_files='current'

" }}}

" {{{ Mappings
let mapleader = "\<Space>"

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

nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>fi       :Files<CR>
nnoremap <leader>C        :Colors<CR>
nnoremap <leader><CR>     :Buffers<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>m        :History<CR>

map <C-_> <Plug>Commentary<CR>

map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

nmap <Leader>p <Plug>(Prettier)

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
