vim.cmd [[packadd packer.nvim]]

return require('packer.nvim').startup(function()
  use { 'wbthomason/packer.nvim', opt = true } -- plugin manager
  use { 'airblade/vim-rooter' } -- set root of git repository
  use { 'andymass/vim-matchup' } -- match more vim words
  use { 'christoomey/vim-tmux-navigator' } -- tmux integration
  use { 'editorconfig/editorconfig-vim' } -- support for editorconfig
  use { 'farmergreg/vim-lastplace' } -- remember last cursor position
  use { 'haya14busa/is.vim' } -- incsearch improved
  use { 'jiangmiao/auto-pairs' } -- auto add closing brackets
  use { 'junegunn/fzf', { run = 'fzf#install()' } } -- fzf
  use { 'junegunn/fzf.vim' } -- fzf integration with vim
  use { 'justinmk/vim-dirvish' } -- fast netrw alternative
  use { 'kristijanhusak/vim-dirvish-git' } -- git support for dirvish
  use { 'matze/vim-move' } -- move lines up and down
  use { 'mg979/vim-visual-multi', { branch = 'master' } } -- multi cursors
  use { 'mhinz/vim-signify' } -- gutter
  use { 'neovim/nvim-lspconfig' } -- neovim lsp common configs
  use { 'nvim-lua/completion-nvim' } -- completion using lsp
  use { 'nvim-lua/diagnostic-nvim' } -- erros and warning using lsp
  use { 'nvim-treesitter/nvim-treesitter' } -- nvim treesiter
  use { 'prettier/vim-prettier', { run = 'npm install' } } -- code formatter
  use { 'sainnhe/gruvbox-material' } -- theme
  use { 'tpope/vim-fugitive' } -- git integration
  use { 'tpope/vim-surround' } -- change surround characters
  use { 'tyru/caw.vim' } -- comment plugin
  use { 'unblevable/quick-scope' } -- improve t and f keys
end)
