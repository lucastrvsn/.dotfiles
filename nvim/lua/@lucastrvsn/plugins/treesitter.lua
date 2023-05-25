-- Always use typescript parser for javascript files
vim.treesitter.language.register("tsx", "javascript")
vim.treesitter.language.register("tsx", "jsx")
vim.treesitter.language.register("tsx", "javascriptreact")

require("nvim-treesitter.configs").setup {
  ignore_install = {
    "javascript",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gv",
      node_incremental = "gvl",
      node_decremental = "gvh",
      scope_incremental = "gvi",
    },
  },
  textobjects = {
    enable = true,
  },
  refactor = {
    highlight_definitions = {
      enable = true,
    },
    highlight_current_scope = {
      enable = false,
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
  },
}
