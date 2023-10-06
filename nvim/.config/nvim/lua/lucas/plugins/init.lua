local path = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(path) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    path,
  }
end

vim.opt.rtp:prepend(path)

require("lazy").setup {
  -- restore the cursor position
  { "ethanholz/nvim-lastplace" },

  -- show git status on signs
  {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require "lucas/plugins/gitsigns"
    end,
  },

  -- configuration for language servers
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "lucas/lsp"
    end,
  },

  -- snippets
  { "dcampos/nvim-snippy" },

  -- completion engine for LSP
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require "lucas/plugins/completion"
    end,
  },

  -- linter and formatter
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require "lucas/plugins/null"
    end,
  },

  -- fuzzy search
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require "lucas/plugins/telescope"
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    config = function()
      require "lucas/plugins/treesitter"
    end,
    build = { ":TSUpdate" },
  },

  -- change working directory to current
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require "lucas/plugins/project"
    end,
  },

  {
    "echasnovski/mini.nvim",
    config = function()
      require "lucas/plugins/mini"
    end,
  },

  -- colorschemes
  {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require "lucas/plugins/colorschemes/tokyonight"
    end,
  },
  {
    "sainnhe/gruvbox-material",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require "lucas/plugins/colorschemes/gruvbox"
    end,
  },
  {
    "edeneast/nightfox.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require "lucas/plugins/colorschemes/nightfox"
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require "lucas/plugins/colorschemes/catppuccin"
    end,
  },
}
