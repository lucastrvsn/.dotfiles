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

  -- configuration for language servers
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "lsp"
    end,
  }

  -- completion engine for LSP
  use {
    "ms-jpq/coq_nvim",
    config = function()
      require "plugins/completion"
    end,
    after = { "nvim-lspconfig" },
  }


  -- linter and formatter
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require "lsp/null"
      require "plugins/null"
    end,
    after = { "nvim-lspconfig" },
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
  use { "tpope/vim-surround" }

  -- comment or toggle section of code
  use {
    "terrortylor/nvim-comment",
    config = function()
      require "plugins/comment"
    end,
  }

  -- smooth scroll
  use {
    "karb94/neoscroll.nvim",
    config = function()
      require "plugins/neoscroll"
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
