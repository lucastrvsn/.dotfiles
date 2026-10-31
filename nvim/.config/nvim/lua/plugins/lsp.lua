local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add {
    source = "neovim/nvim-lspconfig",
  }

  -- From: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
  vim.lsp.config("lua_ls", {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath "config"
          and (
            vim.uv.fs_stat(path .. "/.luarc.json")
            or vim.uv.fs_stat(path .. "/.luarc.jsonc")
          )
        then
          return
        end
      end

      client.config.settings.Lua =
        vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
              "lua/?.lua",
              "lua/?/init.lua",
            },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths
              -- here.
              -- '${3rd}/luv/library',
              -- '${3rd}/busted/library',
            },
            -- Or pull in all of 'runtimepath'.
            -- NOTE: this is a lot slower and will cause issues when working on
            -- your own configuration.
            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
            -- library = vim.api.nvim_get_runtime_file('', true),
          },
        })
    end,
    settings = {
      Lua = {},
    },
  })

  vim.lsp.enable {
    -- "copilot",
    -- "eslint",
    "lua_ls",
    "oxfmt",
    "oxlint",
    "ruff",
    "rust_analyzer",
    "sourcekit",
    "ts_ls",
    "ty",
  }

  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = "lua",
  --   callback = function()
  --     vim.lsp.start {
  --       name = "ailsp",
  --       cmd = { "/Users/lucas/Projects/ailsp/target/debug/ailsp" },
  --       root_dir = vim.fn.getcwd(),
  --       init_options = {
  --         provider = {
  --           type = "openai",
  --           api_key = os.getenv "OPENROUTER_API_KEY",
  --           model = "google/gemma-4-31b-it:free",
  --           base_url = "https://openrouter.ai/api/v1",
  --         },
  --       },
  --       -- root_dir = vim.fs.dirname(vim.fs.find({ ".git", "pyproject.toml" }, { upward = true })[1]),
  --     }
  --   end,
  -- })
end)
