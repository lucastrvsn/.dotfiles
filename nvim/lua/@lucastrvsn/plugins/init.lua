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
  -- integrate with tmux
  { "christoomey/vim-tmux-navigator" },

  -- restore the cursor position
  { "farmergreg/vim-lastplace" },

  -- improve the incsearch command
  { "haya14busa/is.vim" },

  -- simple file explorer
  {
    "elihunter173/dirbuf.nvim",
    config = function()
      require "@lucastrvsn/plugins/explorer"
    end,
  },

  -- show git status on signs
  {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require "@lucastrvsn/plugins/gitsigns"
    end,
  },

  -- configuration for language servers
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "@lucastrvsn/lsp"
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
      require "@lucastrvsn/plugins/completion"
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
      require "@lucastrvsn/plugins/null"
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
      require "@lucastrvsn/plugins/telescope"
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    config = function()
      require "@lucastrvsn/plugins/treesitter"
    end,
    build = { ":TSUpdate" },
  },

  -- change working directory to current
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require "@lucastrvsn/plugins/project"
    end,
  },

  -- change the surround of texts
  {
    "kylechui/nvim-surround",
    config = function()
      require "@lucastrvsn/plugins/surround"
    end,
  },

  -- comment or toggle section of code
  {
    "terrortylor/nvim-comment",
    config = function()
      require "@lucastrvsn/plugins/comment"
    end,
  },

  -- themes
  {
    "edeneast/nightfox.nvim",
    config = function()
      require "@lucastrvsn/plugins/colorschemes/nightfox"
    end,
  },
}
