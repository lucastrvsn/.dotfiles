vim.cmd "packadd packer.nvim"

return require("packer").startup(function(use)
  -- package manager
  use { "wbthomason/packer.nvim" }

  -- integrate with tmux
  use { "christoomey/vim-tmux-navigator" }

  -- restore the cursor position
  use { "farmergreg/vim-lastplace" }

  -- improve the incsearch command
  use { "haya14busa/is.vim" }

  -- icons for some plugins
  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require "plugins/devicons"
    end,
  }

  -- simple file explorer
  use {
    "elihunter173/dirbuf.nvim",
    config = function()
      require "plugins/explorer"
    end,
  }

  -- show git status on signs
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require "plugins/gitsigns"
    end,
  }

  -- editorconfig support
  use { "editorconfig/editorconfig-vim" }

  -- configuration for language servers
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "lsp"
    end,
  }

  -- completion engine for LSP
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require "plugins/completion"
    end,
  }

  -- snippets
  use { "dcampos/nvim-snippy" }

  -- linter and formatter
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require "plugins/null"
    end,
  }

  -- fuzzy search
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require "plugins/telescope"
    end,
  }

  -- enable treesitter on neovim
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-refactor",
      {
        "nvim-treesitter/completion-treesitter",
        run = function()
          vim.cmd "TSUpdate"
        end,
      },
    },
    config = function()
      require "plugins/treesitter"
    end,
  }

  -- change working directory to current
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require "plugins/project"
    end,
  }

  -- change the surround of texts
  use {
    "tpope/vim-surround",
    opt = true,
  }

  -- comment or toggle section of code
  use {
    "terrortylor/nvim-comment",
    config = function()
      require "plugins/comment"
    end,
  }

  -- smooth scroll
  use {
    "declancm/cinnamon.nvim",
    config = function()
      require "plugins/smoothscroll"
    end,
  }

  -- themes
  use { "sainnhe/gruvbox-material" }

  -- personal or dev plugins
  --[[ use {
    "~/Projects/kikwis/vim",
    as = "kikwis",
  }
  use {
    "~/Projects/linha.nvim",
    config = function()
      require "plugins/statusline"
    end,
  } ]]
end)
