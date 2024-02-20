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
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require "lucas.plugins.lastplace"
    end,
  },

  -- basic git integration
  {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require "lucas.plugins.gitsigns"
    end,
  },

  -- language servers
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "lucas.plugins.lsp"
    end,
  },

  -- completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      require "lucas.plugins.completion"
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
      require "lucas.plugins.telescope"
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = { ":TSUpdate" },
    config = function()
      require "lucas.plugins.treesitter"
    end,
  },

  {
    "echasnovski/mini.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "lucas.plugins.comment"
      require "lucas.plugins.explorer"
      require "lucas.plugins.statusline"
      require "lucas.plugins.surround"
    end,
  },

  -- icons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {}
    end,
  },

  -- colorschemes
  {
    "edeneast/nightfox.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup {
        options = {
          terminal_colors = true,
          inverse = {
            match_paren = false,
            visual = true,
            search = false,
          },
          modules = {
            cmp = true,
            gitsigns = true,
            telescope = true,
          },
        },
      }

      vim.cmd.colorscheme "nordfox"
    end,
  },
}
