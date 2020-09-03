" my personal neovim config file
" github.com/lucastrvsn/dotfiles

" default {{{
  let mapleader = "\<Space>"
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1
" }}}

" plugins {{{
try
  call plug#begin()
  " completion
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf
  Plug 'junegunn/fzf.vim' " fzf integration with vim
  Plug 'neovim/nvim-lsp' " neovim lsp
  Plug 'nvim-lua/completion-nvim' " completion using lsp
  Plug 'nvim-lua/diagnostic-nvim' " erros and warning using lsp
  " languages
  Plug 'tpope/vim-git'
  Plug 'othree/html5.vim'
  Plug 'pangloss/vim-javascrip'
  Plug 'elzr/vim-json'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'tbastos/vim-lua'
  Plug 'plasticboy/vim-markdown'
  Plug 'jxnblk/vim-mdx-js'
  Plug 'rust-lang/rust.vim'
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'stephpy/vim-yaml'
  " misc
  Plug 'airblade/vim-rooter' " set root of git repository
  Plug 'andymass/vim-matchup' " match more vim words
  Plug 'editorconfig/editorconfig-vim' " support for editorconfig
  Plug 'farmergreg/vim-lastplace' " remember last cursor position
  Plug 'haya14busa/is.vim' " incsearch improved
  Plug 'itchyny/lightline.vim' " statusline
  Plug 'jiangmiao/auto-pairs' " auto add closing brackets
  Plug 'justinmk/vim-dirvish' " fast netrw alternative
  Plug 'kristijanhusak/vim-dirvish-git' " git support for dirvish
  Plug 'matze/vim-move' " move lines up and down
  Plug 'mg979/vim-visual-multi', { 'branch': 'master' } " multi cursors
  Plug 'mhinz/vim-signify' " gutter
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " code formatter
  Plug 'tpope/vim-eunuch' " unix command integration
  Plug 'tpope/vim-fugitive' " git integration
  Plug 'tpope/vim-surround' " change surround characters
  Plug 'tyru/caw.vim' " comment plugin
  Plug 'yggdroot/indentline' " beatiful line indentation
  " themes
  Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
  Plug 'ayu-theme/ayu-vim'
  call plug#end()
catch
  echom 'vim-plug not installed'
endtry
" }}}

" general {{{
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
  set textwidth=120

  if exists('$TMUX')
    " fix some scroll issues
    set t_ut=
  endif
" }}}

" lua {{{
lua << END
  local lsp = require'nvim_lsp'

  local on_attach = function(client)
    require'diagnostic'.on_attach()
    require'completion'.on_attach()
  end

  -- css
  lsp.cssls.setup{
    on_attach = on_attach
  }

  -- general diagnostic server
  lsp.diagnosticls.setup{
    on_attach = on_attach
  }

  -- html
  lsp.html.setup{
    on_attach = on_attach
  }

  -- json
  lsp.jsonls.setup{
    on_attach = on_attach
  }

  -- rust
  lsp.rls.setup{
    on_attach = on_attach
  }

  -- typescript
  lsp.tsserver.setup{
    on_attach = on_attach
  }

  -- vim
  lsp.vimls.setup{
    on_attach = on_attach
  }

  -- yaml
  lsp.yamlls.setup{
    on_attach = on_attach
  }
END
" }}}

" statusline {{{
  " when not using lightline, use this custom statusline
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
" }}}

" styles {{{
  set termguicolors
  set t_Co=256
  set nocursorline
  set background=dark
  colorscheme ayu
" }}}
endif

" mappings {{{
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
    nnoremap <leader>c :tabnew +terminal<cr>
    tnoremap <leader>c <C-\><C-n>:tabnew +terminal<cr>

    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
  endif
" }}}

" plugin settings {{{
  " nvim-lsp {{{
    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
    nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<cr>
    nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
    nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
    nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
  " }}}

  " completion-nvim {{{
    let g:completion_enable_auto_hover = 1
    let g:completion_auto_change_source = 1
    let g:completion_enable_auto_paren = 0
    let g:completion_auto_change_source = 1

    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <silent><expr> <C-Space> completion#trigger_completion()
  " }}}

  " diagnostic-nvim {{{
    let g:diagnostic_enable_virtual_text = 1
    let g:diagnostic_virtual_text_prefix = emoji#for('warning')
    let g:diagnostic_trimmed_virtual_text = '50'
    let g:diagnostic_enable_underline = 1

    call sign_define("LspDiagnosticsErrorSign", {"text": emoji#for('warning'), "texthl" : "LspDiagnosticsError"})
    call sign_define("LspDiagnosticsWarningSign", {"text": emoji#for('no_entry'), "texthl" : "LspDiagnosticsWarning"})
    call sign_define("LspDiagnosticsInformationSign", {"text": emoji#for('grey_exclamation'), "texthl" : "LspDiagnosticsInformation"})
    call sign_define("LspDiagnosticsHintSign", {"text": emoji#for('bulb'), "texthl" : "LspDiagnosticsHint"})

    highlight! link LspDiagnosticsError SpellBad
    highlight! link LspDiagnosticsHint SpellCap
    highlight! link LspDiagnosticsInfo SpellLocal
    highlight! link LspDiagnosticsWarning SpellRare

    autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()
  " }}}

  " dirvish {{{
    let dirvish_mode = ':sort ,^.*/,'
  " }}}

  " lightline {{{
    let g:lightline = {
      \ 'colorscheme': 'ayu',
      \ 'mode_map': {
      \   'n': 'normal',
      \   'i': 'insert',
      \   'R': 'replace',
      \   'v': 'visual',
      \   'V': 'vline',
      \   "\<C-v>": 'vblock',
      \   'c': 'command',
      \   's': 'select',
      \   'S': 'sline',
      \   "\<C-s>": 'sblock',
      \   't': 'terminal',
      \ },
      \ 'active': {
      \   'left': [ ['mode', 'paste'], [ 'filename' ] ],
      \   'right': [ ['lineinfo', 'gitbranch'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ }
    \}
  " }}}

  " prettier {{{
    let g:prettier#config#single_quote = 'true'
    let g:prettier#config#trailing_comma = 'none'
    let g:prettier#autoformat = 0

    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
  " }}}

  " fzf {{{
    function! FzfOmniFiles()
      if fugitive#head() != ''
        :GitFiles
      else
        :Files
      endif
    endfunction

    nnoremap <C-p>     :call FzfOmniFiles()<cr>
    nnoremap <leader>w :Windows<cr>
    nnoremap <leader>b :Buffers<cr>
    nnoremap <leader>m :History<cr>

    autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  " }}}

  " indentline {{{
    let g:indentLine_enabled = 0 " disable vertical lines
    let g:indentLine_leadingSpaceEnabled = 1 " enable leading spaces
    let g:indentLine_leadingSpaceChar = '·'
  " }}}

  " auto-pairs {{{
    let g:AutoPairsMultilineClose = 0
  " }}}

  " vim-rooter {{{
    let g:rooter_silent_chdir = 1
    let g:rooter_change_directory_for_non_project_files = 'current'
  " }}}
" }}}
