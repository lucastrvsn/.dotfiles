local lspconfig = require("lspconfig")

local function on_attach(e)
  local opts = {
    buffer = e.buf,
    noremap = true,
  }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<Leader>wl", function()
    vim.print(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<Leader>f", function()
    vim.lsp.buf.format {
      async = true,
    }
  end, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = on_attach,
})

local servers = {
  {
    "tsserver",
  },
  {
    "eslint",
    {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    },
  },
  -- {
  --   "denols",
  --   {
  --     on_attach = function(_, bufnr)
  --       vim.api.nvim_create_autocmd("BufWritePre", {
  --         buffer = bufnr,
  --         callback = function ()
  --           vim.lsp.buf.format {
  --             bufnr = bufnr,
  --           }
  --         end
  --       })
  --     end,
  --   },
  -- },
  {
    "lua_ls",
    {
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
    },
  },
  {
    "pyright",
    {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
          },
        },
      },
    },
  },
  {
    "rust_analyzer",
    {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format {}
          end,
        })
      end,
    },
  },
}

for _, v in pairs(servers) do
  local name, config = unpack(v)

  vim.validate {
    name = { name, "string", false },
    config = { config, "table", true },
  }

  lspconfig[name].setup(config or {})
end
