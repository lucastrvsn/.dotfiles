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

require "lucas.plugins.lsp.languages.deno"
require "lucas.plugins.lsp.languages.javascript"
require "lucas.plugins.lsp.languages.lua"
require "lucas.plugins.lsp.languages.python"
require "lucas.plugins.lsp.languages.rust"
