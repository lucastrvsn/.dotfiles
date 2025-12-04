local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add {
    source = "edeneast/nightfox.nvim",
  }

  require("nightfox").setup {
    options = {
      terminal_colors = true,
      inverse = {
        match_paren = false,
        visual = true,
        search = false,
      },
      modules = {
        -- neovim defaults
        diagnostic = true,
        native_lsp = true,
        treesitter = true,
        lsp_semantic_tokens = true,

        -- extra modules
        mini = true,
        oil = true,
      },
    },
  }

  vim.cmd.colorscheme "nordfox"
end)
