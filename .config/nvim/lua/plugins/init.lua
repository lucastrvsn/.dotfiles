vim.cmd[[packadd packer.nvim]]

-- packer.nvim configuration and plugins
require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true }
  use { 'christoomey/vim-tmux-navigator' }
  use { 'farmergreg/vim-lastplace' }
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {
      { 'kyazdani42/nvim-web-devicons', config = function() require('plugins.devicons') end }
    },
    config = function() require('plugins.statusline') end
  }
  use { 'haya14busa/is.vim' }
  use {
    'justinmk/vim-dirvish',
    requires = { 'kristijanhusak/vim-dirvish-git' },
    config = function() require('plugins.dirvish') end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('plugins.gitsigns') end
  }
  use { 'matze/vim-move' }
  use {
    'mhartington/formatter.nvim',
    config = function() require('plugins.formatter') end
  }
  use {
    'neovim/nvim-lspconfig',
    config = function() require('lsp') end
  }
  use {
    'nvim-lua/completion-nvim',
    config = function() require('plugins.completion') end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' }
    },
    config = function() require('plugins.telescope') end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor',
      {
        'nvim-treesitter/completion-treesitter',
        run = function() vim.cmd [[TSUpdate]] end
      }
    },
    config = function() require('plugins.treesitter') end
  }
  use {
    'oberblastmeister/rooter.nvim',
    config = function() require('plugins.rooter') end
  }
  use { 'tpope/vim-eunuch' }
  use {
    'tpope/vim-fugitive',
    config = function() require('plugins.fugitive') end
  }
  use { 'tpope/vim-surround' }
  use { 'tyru/caw.vim' }
  use { 'vim-test/vim-test' }

  use {
    { 'sainnhe/gruvbox-material' },
    { 'embark-theme/vim', as = 'embark' }
  }
end)
