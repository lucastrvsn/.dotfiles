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

  -- vim.lsp.config("copilot", {
  --   name = "copilot_ls",
  --   cmd = { "npx", "@github/copilot-language-server", "--stdio" },
  --   root_markers = { ".git" },
  --   workspace_required = true,
  --   on_attach = function(client, bufnr)
  --     vim.api.nvim_buf_create_user_command(0, "LspCopilotSignIn", function()
  --       client:request("signIn", vim.empty_dict(), nil, bufnr)
  --     end, {})
  --   end,
  --   init_options = {
  --     editorInfo = {
  --       name = "neovim",
  --       version = string.format(
  --         "%d.%d.%d",
  --         version.major,
  --         version.minor,
  --         version.patch
  --       ),
  --     },
  --     editorPluginInfo = {
  --       name = "Github Copilot LSP for Neovim",
  --       version = "0.0.1",
  --     },
  --   },
  --   handlers = {
  --     signIn = function(err, result, ctx)
  --       vim.print(err, result)
  --
  --       if err then
  --         vim.notify(
  --           "Copilot sign in failed: " .. err.message,
  --           vim.log.levels.ERROR
  --         )
  --         return
  --       end
  --       if result and result.status == "success" then
  --         vim.notify("Successfully signed in to Copilot", vim.log.levels.INFO)
  --       else
  --         vim.notify("Copilot sign in failed", vim.log.levels.ERROR)
  --       end
  --     end,
  --   },
  --   settings = {
  --     nextEditSuggestions = {
  --       enabled = true,
  --     },
  --   },
  -- })

  vim.lsp.enable {
    -- "denols"
    -- "copilot",
    "ts_ls",
    "eslint",
    "lua_ls",
    "ty",
    "ruff",
    "rust_analyzer",
  }
end)
