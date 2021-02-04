local lsp_config = require("lspconfig")
local lsp = vim.lsp
local fn = vim.fn

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

require('lsp.bash')
require('lsp.css')
require('lsp.efm')
require('lsp.html')
require('lsp.json')
require('lsp.lua')
require('lsp.rust')
require('lsp.sql')
require('lsp.ts')
require('lsp.vim')
