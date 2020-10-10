" my personal neovim config file
" https://github.com/lucastrvsn/dotfiles

let g:mapleader = "\<Space>"
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/settings.vim
source $HOME/.config/nvim/mappings.vim
source $HOME/.config/nvim/statusline.vim

luafile $HOME/.config/nvim/lsp.lua
luafile $HOME/.config/nvim/treesitter.lua
