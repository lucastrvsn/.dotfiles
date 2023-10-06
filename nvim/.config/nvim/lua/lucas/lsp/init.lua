vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      prefix = "●",
      spacing = 2,
    },
    update_in_insert = false,
    severity_sort = true,
  })

vim.fn.sign_define("DiagnosticSignError", {
  text = "✖",
  texthl = "DiagnosticSignError",
  numhl = "DiagnosticSignError",
})
vim.fn.sign_define("DiagnosticSignWarning", {
  text = "▲",
  texthl = "DiagnosticSignWarning",
  numhl = "DiagnosticSignWarning",
})
vim.fn.sign_define("DiagnosticSignInformation", {
  text = "●",
  texthl = "DiagnosticSignInformation",
  numhl = "DiagnosticSignInformation",
})
vim.fn.sign_define("DiagnosticSignHint", {
  text = "✱",
  texthl = "DiagnosticSignHint",
  numhl = "DiagnosticSignHint",
})

require("lucas/lsp/utils").setup {
  languages = {
    ["go"] = {
      server = "gopls",
      formatter = {
        use = "null",
        auto_format = true,
      },
    },
    ["html"] = {
      server = "html",
      formatter = {
        use = "null",
        auto_format = true,
      },
    },
    ["javascript"] = {
      server = "tsserver",
      formatter = {
        use = "null",
        auto_format = true,
      },
    },
    ["json"] = {
      server = "jsonls",
      formatter = {
        use = "null",
        auto_format = true,
      },
    },
    ["css"] = {
      server = {
        "cssls",
        {
          filetypes = { "css", "sass", "scss" },
          settings = {
            css = {
              validate = true,
            },
            sass = {
              validate = true,
            },
            scss = {
              validate = true,
            },
          },
        },
      },
      formatter = {
        use = "null",
        auto_format = true,
      },
    },
    ["lua"] = {
      server = {
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
      formatter = {
        use = "null",
        auto_format = true,
      },
    },
    ["rust"] = {
      server = {
        "rust_analyzer",
        {
          checkOnSave = true,
          check = {
            command = "clippy",
          },
        },
      },
      formatter = {
        use = "null",
        auto_format = true,
      },
    },
    ["sh"] = {
      server = "bashls",
      formatter = {
        auto_format = true,
      },
    },
    ["sql"] = {
      server = "sqlls",
      formatter = {
        auto_format = true,
      },
    },
    ["vim"] = {
      server = "vimls",
      formatter = {
        auto_format = true,
      },
    },
    ["swift"] = {
      server = {
        "sourcekit",
        {
          cmd = { "xcrun", "sourcekit-lsp" },
        },
      },
    },
    ["python"] = {
      server = {
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
      formatter = {
        use = "null",
        auto_format = true,
      },
    },
  },
}
