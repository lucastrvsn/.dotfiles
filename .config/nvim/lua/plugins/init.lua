vim.cmd "packadd packer.nvim"

require("packer").startup(function()
  -- package manager
  use {
    "wbthomason/packer.nvim",
    opt = true,
  }

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

  -- completion engine for LSP
  use {
    "hrsh7th/nvim-compe",
    config = function()
      require "plugins/completion"
    end,
  }

  -- simple file explorer for vim
  use {
    "justinmk/vim-dirvish",
    requires = { "kristijanhusak/vim-dirvish-git" },
    config = function()
      require "plugins/dirvish"
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

  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  }

  -- run formatters
  use {
    "mhartington/formatter.nvim",
    config = function()
      require "plugins/formatter"
    end,
  }

  -- configuration for language servers
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "lsp"
    end,
  }

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
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
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
    "oberblastmeister/rooter.nvim",
    config = function()
      require "plugins/rooter"
    end,
  }

  -- change the surround of texts
  use { "tpope/vim-surround" }

  -- comment or toggle section of code
  use { "b3nj5m1n/kommentary" }

  -- smooth scroll
  use {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end,
  }

  -- personal or dev plugins
  use {
    "~/Projects/kikwis/vim",
    as = "kikwis",
  }
  use {
    "~/Projects/linha.nvim",
    config = function()
      require "plugins/statusline"
    end,
  }
end)
