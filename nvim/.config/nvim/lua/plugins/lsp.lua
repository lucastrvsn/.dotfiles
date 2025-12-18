local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add {
    source = "neovim/nvim-lspconfig",
  }

  vim.lsp.config("*", {
    diagnostics = {
      virtual_text = {
        prefix = "icons",
      },
    },
  })

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
    },
  })

  vim.lsp.config("rust_analyzer", {
    settings = {
      ["rust-analyzer"] = {},
    },
  })

  vim.lsp.enable {
    -- "denols"
    "ts_ls",
    "eslint",
    "lua_ls",
    "ty",
    "ruff",
    "rust_analyzer",
  }
end)
