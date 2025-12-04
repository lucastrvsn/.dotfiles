local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add {
    source = "stevearc/conform.nvim",
  }

  require("conform").setup {
    formatters_by_ft = {
      lua = { "stylua" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  }
end)
