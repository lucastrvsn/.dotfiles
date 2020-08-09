" my personal neovim config file
" github.com/lucastrvsn

" Plugins {{{
call plug#begin()

Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-rooter'
Plug 'andymass/vim-matchup'
Plug 'danilamihailov/beacon.nvim'
Plug 'haya14busa/is.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'matze/vim-move'
Plug 'mhinz/vim-signify'
Plug 'neovim/nvim-lsp'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tyru/caw.vim'
Plug 'vim-airline/vim-airline'

Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/gruvbox-material'

call plug#end()
" }}}

" General {{{
  " Switch syntax highlighting on, when the terminal has colors
  syntax on

  " Use vim, not vi api
  set nocompatible

  " Use mouse
  set mouse=a

  " Increase history
  set history=10000

  " No backup
  set nobackup
  set nowritebackup
  set noswapfile

  " Undo stuff (send all undo files to /tmp)
  set undodir=/tmp//,.
  set undofile
  set undolevels=1000
  set undoreload=10000

  " Change update time
  set updatetime=100

  " Set magic by default
  set magic

  " Reduce vim messages
  set showcmd
  set ruler
  set shortmess=atOI

  " Scroll offset
  set scrolloff=4

  " Hide mouse cursor when typing
  set mousehide

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

  " Display much as possible on lastline
  set display=lastline

  " Convert tabs to spaces
  set expandtab
  set smarttab

  " Set tab size in spaces (manual indenting)
  set tabstop=2

  " The number of spaces inserted for a tab (auto indenting)
  set softtabstop=2
  set shiftwidth=2

  " Turn on line numbers
  set number
  set relativenumber

  " Improve terminal colors
  set termguicolors
  set t_Co=256

  " Highlight tailing whitespace
  " See: https://github.com/Integralist/ProVim/issues/4
  set list listchars=tab:·\ ,trail:·

  " Get rid of the delay when pressing O (for example)
  " http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
  set timeout
  set timeoutlen=1000
  set ttimeoutlen=100

  " Always show status bar
  set laststatus=2
  set showtabline=0
  set noshowmode

  " Set wildmenu
  set wildmenu
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,**/node_modules/**
  set path+=**

  " UTF encoding
  set encoding=utf-8
  set fileencoding=utf-8
  set termencoding=utf-8

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

  " Fix some scroll issues with tmux
  set t_ut=
" }}}

" Mappings {{{
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
  vmap <silent> < <gv
  vmap <silent> > >gv

  " neovim terminal
  if has('nvim')
    au TermOpen * tnoremap <Esc> <C-\><C-n>
    au FileType fzf tunmap <Esc>
    nnoremap <leader>c :tabnew +terminal<CR>
    tnoremap <leader>c <C-\><C-n>:tabnew +terminal<CR>

    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
  endif
" }}}

" Plugin settings {{{
  " coc {{{
    " let g:coc_global_extensions = [
    "  \ 'coc-browser',
    "  \ 'coc-css',
    "  \ 'coc-cssmodules',
    "  \ 'coc-explorer',
    "  \ 'coc-git',
    "  \ 'coc-highlight',
    "  \ 'coc-html',
    "  \ 'coc-json',
    "  \ 'coc-markdownlint',
    "  \ 'coc-pairs',
    "  \ 'coc-rls',
    "  \ 'coc-tsserver',
    "  \ 'coc-yaml',
    "  \ 'coc-yank'
    "\]
    " 
    " function! s:show_documentation()
    "   if (index(['vim', 'help'], &filetype) >= 0)
    "     execute 'h ' . expand('<cword>')
    "   else
    "     call CocAction('doHover')
    "   endif
    " endfunction
    " 
    " " use <tab> for trigger completion and navigate to the next complete item
    " function! s:check_back_space() abort
    "   let col = col('.') - 1
    "   return !col || getline('.')[col - 1]  =~ '\s'
    " endfunction
    " 
    " nmap <silent> gd          <Plug>(coc-definition)
    " nmap <silent> gi          <Plug>(coc-implementation)
    " nmap <silent> gr          <Plug>(coc-references)
    " 
    " nnoremap <silent> K :call <SID>show_documentation()<CR>
    " inoremap <silent><expr> <Tab>
    "  \ pumvisible() ? "\<C-n>" :
    "  \ <SID>check_back_space() ? "\<Tab>" :
    "  \ coc#refresh()
    " inoremap <silent><expr> <c-space> coc#refresh()
    " inoremap <silent><expr> <NUL> coc#refresh()
    " inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " 
    " " use coc-explorer to browse through files
    " nmap <leader>e :CocCommand explorer --position floating --focus --quit-on-open<CR>
    " 
    " autocmd CursorHold * silent call CocActionAsync('highlight')
       r


  " deoplete.nvim {{{
    let g:deoplete#enable_at_startup = 1
  " }}}

  " Prettier {{{
    let g:prettier#config#single_quote = 'true'
    let g:prettier#config#trailing_comma = 'none'
    let g:prettier#autoformat = 0

    nmap <leader>p <Plug>(Prettier)

    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
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
    nnoremap <leader>w        :Windows<CR>
    nnoremap <leader>b        :Buffers<CR>
    nnoremap <leader>fi       :Files<CR>
    nnoremap <leader>C        :Colors<CR>
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
    let g:CtrlSpaceDefaultMappingKey = '<C-space> '

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
    \   exe "normal g`\'" |
    \ endif
" }}}

" {{{ Theme
  set background=dark
  colorscheme gruvbox-material

  hi EndOfBuffer guifg=bg
" }}}
