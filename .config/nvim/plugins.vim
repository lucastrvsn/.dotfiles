try
  call plug#begin()
  " completion
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf
  Plug 'junegunn/fzf.vim' " fzf integration with vim
  Plug 'neovim/nvim-lspconfig' " neovim lsp common configs
  Plug 'nvim-lua/completion-nvim' " completion using lsp
  Plug 'nvim-lua/diagnostic-nvim' " erros and warning using lsp
  Plug 'nvim-treesitter/nvim-treesitter' " nvim treesiter
  " languages
  Plug 'HerringtonDarkholme/yats.vim' " typescript
  Plug 'MaxMEllon/vim-jsx-pretty' " jsx
  Plug 'arzg/vim-sh' " shell
  Plug 'cakebaker/scss-syntax.vim' " scss
  Plug 'elzr/vim-json' " json
  Plug 'jxnblk/vim-mdx-js' " mdx
  Plug 'othree/html5.vim' " html
  Plug 'pangloss/vim-javascript' " js
  Plug 'plasticboy/vim-markdown' " md
  Plug 'rust-lang/rust.vim' " rust
  Plug 'stephpy/vim-yaml' " yaml
  Plug 'tbastos/vim-lua' " lua
  Plug 'tpope/vim-git' " git
  Plug 'vim-jp/vim-cpp' " c/cpp
  " misc
  Plug 'unblevable/quick-scope' " improve t and f keys
  Plug 'airblade/vim-rooter' " set root of git repository
  Plug 'andymass/vim-matchup' " match more vim words
  Plug 'christoomey/vim-tmux-navigator' " tmux integration
  Plug 'editorconfig/editorconfig-vim' " support for editorconfig
  Plug 'farmergreg/vim-lastplace' " remember last cursor position
  Plug 'haya14busa/is.vim' " incsearch improved
  Plug 'jiangmiao/auto-pairs' " auto add closing brackets
  Plug 'justinmk/vim-dirvish' " fast netrw alternative
  Plug 'kristijanhusak/vim-dirvish-git' " git support for dirvish
  Plug 'machakann/vim-highlightedyank' " highlight yanked text
  Plug 'matze/vim-move' " move lines up and down
  Plug 'xuyuanp/scrollbar.nvim' " show scrollbar
  Plug 'mg979/vim-visual-multi', { 'branch': 'master' } " multi cursors
  Plug 'mhinz/vim-signify' " gutter
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " code formatter
  Plug 'tpope/vim-eunuch' " unix command integration
  Plug 'tpope/vim-fugitive' " git integration
  Plug 'tpope/vim-surround' " change surround characters
  Plug 'tyru/caw.vim' " comment plugin
  Plug 'yggdroot/indentline' " beatiful line indentation
  " themes
  Plug 'alessandroyorba/sierra'
  Plug 'glepnir/oceanic-material'
  Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
  Plug 'ayu-theme/ayu-vim'
  call plug#end()
catch
  echom 'vim-plug not installed'
endtry

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

  " autocmd CursorHold * silent lua vim.lsp.buf.hover()
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
  let g:diagnostic_virtual_text_prefix = '>'
  let g:diagnostic_trimmed_virtual_text = '50'
  let g:diagnostic_enable_underline = 1

  call sign_define("LspDiagnosticsErrorSign", {"text": "✖", "texthl" : "LspDiagnosticsError"})
  call sign_define("LspDiagnosticsWarningSign", {"text": "⚠", "texthl" : "LspDiagnosticsWarning"})
  call sign_define("LspDiagnosticsInformationSign", {"text": "▶", "texthl" : "LspDiagnosticsInformation"})
  call sign_define("LspDiagnosticsHintSign", {"text": "★", "texthl" : "LspDiagnosticsHint"})

  highlight! link LspDiagnosticsError SpellBad
  highlight! link LspDiagnosticsHint SpellCap
  highlight! link LspDiagnosticsInfo SpellLocal
  highlight! link LspDiagnosticsWarning SpellRare

  autocmd CursorHold * silent lua vim.lsp.util.show_line_diagnostics()
" }}}

" dirvish {{{
  let dirvish_mode = ':sort ,^.*/,'

  command! -nargs=? -complete=dir Explore Dirvish <args>
  command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
  command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
" }}}

" quick-scope {{{
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
  augroup END
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

  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  let g:fzf_layout = { 'down': '~40%' }
  let $FZF_DEFAULT_COMMAND="rg --files --hidden --smart-case"

  nnoremap <C-p>     :Files<cr>
  nnoremap <leader>w :Windows<cr>
  nnoremap <leader>g :Rg<cr>
  nnoremap <leader>b :Buffers<cr>
  nnoremap <leader>h :History<cr>

  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
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

" scrollbar.nvim {{{
  let g:scrollbar_shape = {
    \ 'head': '',
    \ 'body': '█',
    \ 'tail': '',
    \ }
  let g:scrollbar_highlight = {
    \ 'head': 'StatusLineNC',
    \ 'body': 'StatusLineNC',
    \ 'tail': 'StatusLineNC',
    \ }

  augroup scrollbar_nvim
    autocmd!
    autocmd BufEnter    * silent! lua require('scrollbar').show()
    autocmd BufLeave    * silent! lua require('scrollbar').clear()
    autocmd CursorMoved * silent! lua require('scrollbar').show()
    autocmd VimResized  * silent! lua require('scrollbar').show()
    autocmd FocusGained * silent! lua require('scrollbar').show()
    autocmd FocusLost   * silent! lua require('scrollbar').clear()
  augroup end
" }}}
