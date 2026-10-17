local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add {
    source = "edeneast/nightfox.nvim",
  }

  require("nightfox").setup {
    options = {
      transparent = false,
      terminal_colors = true,
      inverse = {
        match_paren = true,
        visual = false,
        search = false,
      },
      styles = {
        comments = "italic",
      },
      modules = {
        -- neovim defaults
        diagnostic = {
          enable = true,
          background = true,
        },
        native_lsp = true,
        lsp_semantic_tokens = true,
        treesitter = true,

        -- extra modules
        mini = true,
        oil = true,
      },
    },
  }

  vim.cmd.colorscheme "nightfox"
end)
