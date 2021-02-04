local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
  ensure_installed = "all",
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true
  },
  textobjects = {
    enable = true
  },
  refactor = {
    highlight_definitions = {
      enable = true
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      }
    }
  }
})
