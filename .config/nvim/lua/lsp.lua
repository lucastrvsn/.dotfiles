local lsp_config = require("lspconfig")
local lsp = vim.lsp
local api = vim.api
local fn = vim.fn
local g = vim.g

-- nvim-completion
g.completion_enable_auto_popup = 1
g.completion_matching_strategy_list = { "exact", "substring", "fuzzy", "all" }
g.completion_auto_change_source = 1
g.completion_matching_smart_case = 1
g.completion_enable_auto_paren = 1

api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true, noremap = true })
api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true, noremap = true })

-- lsp
lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      prefix = "●",
      spacing = 4,
    }
  }
)

fn.sign_define("LspDiagnosticsSignError", { text = "🞮", numhl = "LspDiagnosticsDefaultError" })
fn.sign_define("LspDiagnosticsSignWarning", { text = "▲", numhl = "LspDiagnosticsDefaultWarning" })
fn.sign_define("LspDiagnosticsSignInformation", { text = "⁈", numhl = "LspDiagnosticsDefaultInformation" })
fn.sign_define("LspDiagnosticsSignHint", { text = "⯁", numhl = "LspDiagnosticsDefaultHint" })

local on_attach = function(client)
  require("completion").on_attach(client)

  local options = {
    noremap = true,
    silent = true
  }

  api.nvim_set_keymap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", options)
  api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", options)
  api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
  api.nvim_set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", options)
  api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", options)
  api.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", options)
  api.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", options)
  api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", options)
  api.nvim_command([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
end

-- lsp setup
lsp_config.bashls.setup({
  on_attach = on_attach
})

lsp_config.cssls.setup({
  on_attach = on_attach
})

lsp_config.diagnosticls.setup({
  on_attach = on_attach,
  filetypes={
    "markdown",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact"
  },
  init_options = {
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = { ".git" },
        args = {
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json"
        },
        debounce = 100,
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [2] = "error",
          [1] = "warning",
        },
      },
      markdownlint = {
        sourceName = "markdownlint",
        command = "markdownlint",
        args = { "--stdin" },
        isStderr = true,
        debounce = 100,
        offsetLine = 0,
        offsetColumn = 0,
        formatLines = 1,
        formatPattern = {
          "^.*?:\\s+(\\d+):\\s+(.*)(\\r|\\n)*$",
          {
            line = 1,
            column = -1,
            message = 2
          }
        }
      }
    },
    filetypes = {
      markdown = "markdownlint",
      javascript = "eslint",
      typescript = "eslint",
      javascriptreact = "eslint",
      typescriptreact = "eslint",
    }
  }
})

-- local root_markers = { ".git/" }
-- 
-- local eslint = {
--   lintCommand = "eslint_d -f unix --stdin",
--   lintStdin = true,
--   lintIgnoreExitCode = true
-- }
-- 
-- local languages = {
--   javascript = { eslint },
--   javascriptreact = { eslint },
--   typescript = { eslint },
--   typescriptreact = eslint
-- }
-- 
-- lsp_config.efm.setup({
--   on_attach = on_attach,
--   cmd = { "efm-langserver" },
--   root_dir = lsp_config.util.root_pattern(unpack(root_markers)),
-- 
--   log_level = vim.lsp.protocol.MessageType.Log,
--   message_level = vim.lsp.protocol.MessageType.Log,
-- 
--   settings = {
--     rootMarkers = root_markers,
--     languages = languages
--   },
--   filetypes = vim.tbl_keys(languages),
-- })

lsp_config.html.setup({
  on_attach = on_attach
})

lsp_config.jsonls.setup({
  on_attach = on_attach
})

lsp_config.rust_analyzer.setup({
  on_attach = on_attach
})

lsp_config.sumneko_lua.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {
          "vim",
          "describe",
          "it",
          "before_each",
          "after_each",
          "awesome",
          "theme",
          "client"
        }
      }
    }
  }
})

lsp_config.tsserver.setup({
  on_attach = on_attach
})

lsp_config.sqlls.setup({
  on_attach = on_attach
})

lsp_config.vimls.setup({
  on_attach = on_attach
})

