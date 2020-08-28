" my personal neovim config file
" github.com/lucastrvsn

" plugins {{{
try
  call plug#begin()
  " style
  Plug 'sainnhe/sonokai'
  Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
  " completion
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'neovim/nvim-lsp'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/diagnostic-nvim'
  Plug 'nvim-lua/lsp-status.nvim'
  " languages
  Plug 'sheerun/vim-polyglot'
  " misc
  Plug 'justinmk/vim-dirvish'
  Plug 'kristijanhusak/vim-dirvish-git'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'farmergreg/vim-lastplace'
  Plug 'vim-test/vim-test'
  Plug 'airblade/vim-rooter'
  Plug 'andymass/vim-matchup'
  Plug 'haya14busa/is.vim'
  Plug 'matze/vim-move'
  Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
  Plug 'mhinz/vim-signify'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'tyru/caw.vim'
  Plug 'yggdroot/indentline'
  call plug#end()
catch
  echom 'vim-plug not installed'
endtry
" }}}

lua << END
  local lsp = require('nvim_lsp')

  local on_attach = function(client)
    require('lsp-status').on_attach(client)
    require('diagnostic').on_attach(client)
    require('completion').on_attach(client)
  end

  lsp.tsserver.setup({
    on_attach = on_attach
  })
END

" general {{{
  " switch syntax highlighting on, when the terminal has colors
  syntax on

  " use vim, not vi api
  set nocompatible

  " use mouse
  set mouse=a

  " increase history
  set history=10000

  " no backup
  set nobackup
  set nowritebackup
  set noswapfile

  " undo stuff (send all undo files to /tmp)
  set undodir=/tmp//,.
  set undofile
  set undolevels=1000
  set undoreload=10000

  " change update time
  set updatetime=100

  " set magic by default
  set magic

  " set terminal title
  set title

  " reduce vim messages
  set showcmd
  set ruler

  " improve completion
  set shortmess+=c
  set completeopt=menuone,noinsert,noselect

  " scroll offset
  set scrolloff=4

  " incremental searching (search as you type)
  set incsearch

  " highlight search matches
  set hlsearch

  " ignore case in search
  set smartcase

  " make sure any searches /searchPhrase doesn't need the \c escape character
  set ignorecase

  " A buffer is marked as ‘hidden’ if it has unsaved changes, and it is not currently loaded in a window
  " if you try and quit Vim while there are hidden buffers, you will raise an error:
  " E162: No write since last change for buffer “a.txt”
  set hidden

  " turn word wrap off
  set nowrap

  " allow backspace to delete end of line, indent and start of line characters
  set backspace=indent,eol,start

  " display much as possible on lastline
  set display=lastline

  " convert tabs to spaces
  set expandtab
  set smarttab

  " set tab size in spaces (manual indenting)
  set tabstop=2

  " the number of spaces inserted for a tab (auto indenting)
  set softtabstop=2
  set shiftwidth=2

  " turn on line numbers and sign column
  set number
  set relativenumber
  set signcolumn=number

  " improve terminal colors
  set termguicolors
  set t_Co=256

  " highlight tailing whitespace
  " https://github.com/Integralist/ProVim/issues/4
  set list listchars=tab:·\ ,trail:·

  " get rid of the delay when pressing O (for example)
  " http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
  set timeout
  set timeoutlen=1000
  set ttimeoutlen=100

  " always show status bar
  set showtabline=0
  set noshowmode

  " statusline
  let g:current_mode = {
    \ 'n': 'normal',
    \ 'v': 'visual',
    \ 'V': 'vline',
    \ "\<C-V>": 'vblock',
    \ 'i': 'insert',
    \ 'R': 'replace',
    \ 'Rv': 'vreplace',
    \ 'c': 'command',
    \ 't': 'terminal',
  \}

  function! CurrentMode() abort
    let l:current = mode()
    return get(g:current_mode, l:current, l:current)
  endfunction

  function! LspStatusLine() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
      return luaeval("require('lsp-status').status()")
    endif
    return ''
  endfunction

  set laststatus=2
  set statusline= " left side
  set statusline+=%#ToolbarLine#
  set statusline+=\ %{CurrentMode()}\ %*
  set statusline+=%{&modified?'\ •':''}
  set statusline+=\ [%n%H%R%W]%*\ 
  set statusline+=%f\ 
  set statusline+=%{LspStatusLine()}
  set statusline+=%= " right side
  set statusline+=%#Statement#%{fugitive#head()}%*\ 
  set statusline+=%l/%L\ %p%%\ 

  " set wildmenu
  set path+=**
  set wildmenu
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,**/node_modules/**

  " UTF encoding
  set encoding=utf-8
  set fileencoding=utf-8
  set termencoding=utf-8

  " autoload files that have changed outside of vim
  set autoread

  " better splits (new windows appear below and to the right)
  set splitbelow
  set splitright

  " ensure Vim doesn't beep at you every time you make a mistype
  set visualbell
  set noerrorbells

  " highlight a matching [{()}] when cursor is placed on start/end character
  set showmatch

  " always highlight column 80 so it's easier to see where
  " cutoff appears on longer screens
  set colorcolumn=80

  " cursor line
  set cursorline

  " tmux
  if exists('$TMUX')
    " fix some scroll issues
    set t_ut=
  endif
" }}}

" colorscheme {{{
  set background=dark
  colorscheme challenger_deep
" }}}

" mappings {{{
  let mapleader = "\<Space>"

  " moving up and down the right way
  nnoremap <silent>j gj
  nnoremap <silent>k gk
  nnoremap <silent>^ g^
  nnoremap <silent>$ g$

  " remove arrow keys mappings
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exec 'noremap' key '<Nop>'
    exec 'inoremap' key '<Nop>'
  endfor

  " keep visual selection when indenting
  vmap <silent> < <gv
  vmap <silent> > >gv

  " deal with clipboard
  nnoremap <leader>y "+y
  vnoremap <leader>y "+y
  nnoremap <leader>p "+p
  vnoremap <leader>p "+p
  nnoremap <leader>P "+P

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

" plugin settings {{{
  " nvim-lsp {{{
    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
  " }}}

  " completion-nvim {{{
    let g:completion_enable_auto_hover = 1
    let g:completion_auto_change_source = 1
    let g:completion_enable_auto_paren = 0
    let g:completion_timer_cycle = 80
    let g:completion_auto_change_source = 1

    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <silent><expr> <C-Space> completion#trigger_completion()
  " }}}

  " diagnostic-nvim {{{
    let g:diagnostic_level = 'Warning'
    let g:diagnostic_enable_virtual_text = 1
    let g:diagnostic_virtual_text_prefix = ' '
    let g:diagnostic_trimmed_virtual_text = '20'
    let g:diagnostic_insert_delay = 1

    call sign_define("LspDiagnosticsErrorSign", {"text" : ">>", "texthl" : "LspDiagnosticsError"})
    call sign_define("LspDiagnosticsWarningSign", {"text" : "⚡", "texthl" : "LspDiagnosticsWarning"})
    call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
    call sign_define("LspDiagnosticsHintSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})

    autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()
  " }}}

  " dirvish {{{
    let dirvish_mode = ':sort ,^.*/,'
    let loaded_netrwPlugin = 1 " disable netrw
  " }}}

  " prettier {{{
    let g:prettier#config#single_quote = 'true'
    let g:prettier#config#trailing_comma = 'none'
    let g:prettier#autoformat = 0

    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
  " }}}
  
  " vim-test {{{
    nmap <silent> t<C-n> :TestNearest<CR>
    nmap <silent> t<C-f> :TestFile<CR>
    nmap <silent> t<C-s> :TestSuite<CR>
    nmap <silent> t<C-l> :TestLast<CR>
    nmap <silent> t<C-g> :TestVisit<CR>
  " }}}
  
  " fzf {{{
    function! FzfOmniFiles()
      if fugitive#head() != ''
        :GitFiles
      else
        :Files
      endif
    endfunction

    nnoremap <C-p>     :call FzfOmniFiles()<CR>
    nnoremap <leader>w :Windows<CR>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader>m :History<CR>

    autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  " }}}

  " indentline {{{
    let g:indentLine_enabled = 0 " disable vertical lines
    let g:indentLine_leadingSpaceEnabled = 1 " enable leading spaces
    let g:indentLine_leadingSpaceChar = '·'
  " }}}

  " vim-rooter {{{
    let g:rooter_silent_chdir = 1
    let g:rooter_change_directory_for_non_project_files = 'current'
  " }}}
" }}}

" {{{ autocommands
" //
" }}}
