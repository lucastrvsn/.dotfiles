try
  call plug#begin()
  Plug 'airblade/vim-rooter' " set root of git repository
  Plug 'andymass/vim-matchup' " match more vim words
  Plug 'christoomey/vim-tmux-navigator' " tmux integration
  Plug 'dkarter/bullets.vim' " markdown bullets
  Plug 'editorconfig/editorconfig-vim' " support for editorconfig
  Plug 'farmergreg/vim-lastplace' " remember last cursor position
  Plug 'haya14busa/is.vim' " incsearch improved
  Plug 'jiangmiao/auto-pairs' " auto add closing brackets
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf
  Plug 'junegunn/fzf.vim' " fzf integration with vim
  Plug 'justinmk/vim-dirvish' " fast netrw alternative
  Plug 'kristijanhusak/vim-dirvish-git' " git support for dirvish
  Plug 'matze/vim-move' " move lines up and down
  Plug 'mg979/vim-visual-multi', { 'branch': 'master' } " multi cursors
  Plug 'mhinz/vim-signify' " gutter
  Plug 'neovim/nvim-lspconfig' " neovim lsp common configs
  Plug 'nvim-lua/completion-nvim' " completion using lsp
  Plug 'nvim-lua/diagnostic-nvim' " erros and warning using lsp
  Plug 'nvim-treesitter/nvim-treesitter' " nvim treesiter
  Plug 'prettier/vim-prettier', { 'do': 'npm install' } " code formatter
  Plug 'sainnhe/gruvbox-material' " theme
  Plug 'tpope/vim-fugitive' " git integration
  Plug 'tpope/vim-surround' " change surround characters
  Plug 'tyru/caw.vim' " comment plugin
  Plug 'unblevable/quick-scope' " improve t and f keys
  call plug#end()
catch
  echom 'vim-plug not installed'
endtry

" completion-nvim {{{
  let g:completion_enable_auto_hover = 1
  let g:completion_auto_change_source = 1
  let g:completion_enable_auto_paren = 0
  let g:completion_auto_change_source = 1
  let g:completion_matching_smart_case = 1

  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}

" diagnostic-nvim {{{
  let g:diagnostic_enable_virtual_text = 1
  let g:diagnostic_virtual_text_prefix = '━ '
  let g:diagnostic_enable_underline = 1

  call sign_define("LspDiagnosticsErrorSign", {"text": "❌", "texthl" : "LspDiagnosticsError"})
  call sign_define("LspDiagnosticsWarningSign", {"text": "⚠️", "texthl" : "LspDiagnosticsWarning"})
  call sign_define("LspDiagnosticsInformationSign", {"text": "ℹ️", "texthl" : "LspDiagnosticsInformation"})
  call sign_define("LspDiagnosticsHintSign", {"text": "💡", "texthl" : "LspDiagnosticsHint"})

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

  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
" }}}

" fzf {{{
  let g:fzf_action = {
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  let g:fzf_layout = { 'down': '~40%' }
  let $FZF_DEFAULT_COMMAND="rg --files --hidden --smart-case"

  nnoremap <expr> <C-p> FugitiveHead() != '' ? ':GitFiles<CR>' : ':Files<CR>'
  nnoremap <leader>w :Windows<cr>
  nnoremap <leader>g :Rg<cr>
  nnoremap <leader>b :Buffers<cr>
  nnoremap <leader>h :History<cr>

  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" }}}

" auto-pairs {{{
  let g:AutoPairsMultilineClose = 0
" }}}

" vim-rooter {{{
  let g:rooter_silent_chdir = 1
  let g:rooter_change_directory_for_non_project_files = 'current'
" }}}
