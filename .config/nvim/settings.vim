syntax on
set nocompatible
set mouse=a
set history=10000
set nobackup
set nowritebackup
set noswapfile
set undodir=/tmp//,. " semi-persist undo
set undofile
set undolevels=1000
set undoreload=10000
set updatetime=100
set lazyredraw
set title
set showcmd
set cmdheight=1
set ruler
set shortmess+=c
set completeopt=menuone,noinsert,noselect
set scrolloff=4
set incsearch
set hlsearch
set smartcase
set ignorecase
set hidden
set nowrap
set backspace=indent,eol,start
set display=lastline
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set number
set relativenumber
set signcolumn=number
set list
set listchars=tab:·\ ,trail:·
set timeout
set timeoutlen=1000
set ttimeoutlen=100
set showtabline=0
set noshowmode
set path+=**
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,**/node_modules/**
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set autoread
set splitbelow
set splitright
set visualbell
set noerrorbells
set showmatch
set colorcolumn=80
set textwidth=80

if exists('$TMUX')
  set t_ut=
endif

" styles {{{
  set termguicolors
  set background=dark
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

  " let g:oceanic_material_transparent_background = 0
  " let g:oceanic_material_allow_reverse = 1
  " let g:oceanic_material_background = 'ocean'
  let g:gruvbox_material_background = 'soft'
  colorscheme gruvbox-material

  hi! link Directory Title

  autocmd BufEnter * :syntax sync fromstart
" }}}
