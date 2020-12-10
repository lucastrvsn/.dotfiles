" my personal neovim config file
" https://github.com/lucastrvsn/dotfiles

let g:mapleader = "\<Space>"

if !exists('g:vscode')
  let g:loaded_gzip = 1
  let g:loaded_matchparen = 1
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1
  let g:loaded_tarPlugin = 1
  let g:loaded_tutor_mode_plugin = 1
  let g:loaded_zipPlugin = 1

  source $HOME/.config/nvim/plugins.vim
  source $HOME/.config/nvim/settings.vim
  source $HOME/.config/nvim/mappings.vim
  source $HOME/.config/nvim/statusline.vim
  luafile $HOME/.config/nvim/lua/plugins.lua
  luafile $HOME/.config/nvim/lua/lsp.lua
  luafile $HOME/.config/nvim/lua/treesitter.lua
else
  source $HOME/.config/nvim/vscode/plugins.vim
  source $HOME/.config/nvim/vscode/settings.vim
  source $HOME/.config/nvim/vscode/mappings.vim
endif
