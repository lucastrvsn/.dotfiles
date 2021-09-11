local M = {}

M.init = function()
  vim.lsp.handlers['textdocument/publishdiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = {
        prefix = '●',
        spacing = 2
      }
    }
  )

  vim.fn.sign_define(
    'LspDiagnosticsSignError',
    {
      text = '🞮',
      numhl = 'LspDiagnosticsDefaultError'
    }
  )
  vim.fn.sign_define(
    'LspDiagnosticsSignWarning',
    {
      text = '▲',
      numhl = 'LspDiagnosticsDefaultWarning'
    }
  )
  vim.fn.sign_define(
    'LspDiagnosticsSignInformation',
    {
      text = '⁈',
      numhl = 'LspDiagnosticsDefaultInformation'
    }
  )
  vim.fn.sign_define(
    'LspDiagnosticsSignHint',
    {
      text = 'H',
      numhl = 'LspDiagnosticsDefaultHint'
    }
  )
end
