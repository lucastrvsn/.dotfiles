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
set updatetime=500
set nocursorline
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

" {{{ https://github.com/cempassi/.dotfiles/blob/a7d3d8fdd2a03ead1498c99ffd98e2abcf60cffa/neovim/.config/nvim/init.vim#L83
set formatoptions-=a    " Turn off auto formating.
set formatoptions-=t    " Turn off auto formating.
set formatoptions+=c    " Comment respect textwidth
set formatoptions+=q    " Allow formatting comments w/ gq
set formatoptions-=o    " O and o, don't continue comments
set formatoptions+=r    " But do continue when pressing enter.
set formatoptions+=n    " Indent past the formatlistpat, not underneath it.
set formatoptions+=j    " Auto-remove comments if possible.
set formatoptions-=2    " Useless option
set nojoinspaces        " Useless option 2
" }}}

set incsearch
set inccommand=nosplit
set hlsearch
set smartcase
set ignorecase
set gdefault
set hidden
set nowrap
set backspace=indent,eol,start
set display=lastline
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set magic
set number
set relativenumber
set pumblend=16
set winblend=16
set pumheight=14
set signcolumn=yes:1
set list listchars=tab:░░,trail:·
set fillchars=eob:~
set timeout
set timeoutlen=1000
set ttimeoutlen=100
set showtabline=0
set noshowmode
set path+=**
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,*/dist*/*,*/target/*,*/builds/*,*/build/*,tags,*/lib/*,*/flow-typed/*,*/node_modules/*,*.png,*.PNG,*.jpg,*.jpeg,*.JPG,*.JPEG,*.pdf,*.exe,*.o,*.obj,*.dll,*.DS_Store,*.ttf,*.otf,*.woff,*.woff2,*.eot
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

" folding with treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99

" styles {{{
  " TODO: Move this section to another file
  set termguicolors
  set background=dark
  " set guicursor=n-v-c-sm:block,i-ci-ve:ver50-Cursor,r-cr-o:hor50 " using cursor block only for normal mode
  set guicursor=n-v-c:block-nCursor " using cursor block for everything

  let &t_Cs = "\<Esc>[4:3m"
  let &t_Ce = "\<Esc>[4:0m"
  let g:gruvbox_material_palette = 'material'
  let g:gruvbox_material_background = 'hard'
  let g:gruvbox_material_enable_italic = 1
  let g:gruvbox_material_transparent_background = 0
  let g:gruvbox_material_diagnostic_line_highlight = 1

  colorscheme gruvbox-material
" }}}

" highlight yank for 500ms
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({ higroup = 'Substitute', timeout = 500 })
augroup END
