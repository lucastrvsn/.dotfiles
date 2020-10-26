syntax on

set nocompatible
set mouse=nvh
set history=10000
set nobackup
set nowritebackup
set noswapfile
set undodir=/tmp//,.
set undofile
set undolevels=1000
set undoreload=10000
set updatetime=100
set cursorline
set lazyredraw
set title
set titlestring=%-25.55F\ %a%r%m\ -\ nvim
set titlelen=80
set showcmd
set cmdheight=1
set ruler
set shortmess+=c
set completeopt=menuone,noinsert,noselect
set scrolloff=4
set sidescrolloff=4
set incsearch
set inccommand=nosplit
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
set pumblend=20
set pumheight=15
set signcolumn=number
set list listchars=tab:░░,trail:·
set timeout
set timeoutlen=1000
set ttimeoutlen=100
set showtabline=0
set noshowmode
set path+=**
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,*/dist*/*,*/target/*,*/builds/*,tags,*/lib/*,*/flow-typed/*,*/node_modules/*,*.png,*.PNG,*.jpg,*.jpeg,*.JPG,*.JPEG,*.pdf,*.exe,*.o,*.obj,*.dll,*.DS_Store,*.ttf,*.otf,*.woff,*.woff2,*.eot
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
set synmaxcol=120

if exists('$TMUX')
  set t_ut=
endif

" styles {{{
  set termguicolors
  set background=dark
  set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20

  let g:gruvbox_material_palette = 'material'
  let g:gruvbox_material_background = 'medium'
  colorscheme gruvbox-material

  autocmd BufEnter * :syntax sync fromstart
" }}}

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
