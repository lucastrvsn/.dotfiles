---@class _.lsp.utils.keymaps
local M = {}

---@class _.lsp.utils.keymaps.setup.options
---@field buffer number

---@param opts _.lsp.utils.keymaps.setup.options
function M.setup(opts)
  vim.validate {
    opts = { opts, "table", false },
    ["opts.buffer"] = { opts.buffer, "number", false },
  }

  local default_opts = {
    buffer = opts.buffer,
    noremap = true,
    silent = true,
  }

  vim.keymap.set("n", "gD", function()
    vim.lsp.buf.declaration()
  end, default_opts)

  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, default_opts)

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, default_opts)

  vim.keymap.set("n", "gi", function()
    vim.lsp.buf.implementation()
  end, default_opts)

  vim.keymap.set("n", "<Leader>k", function()
    vim.lsp.buf.signature_help()
  end, default_opts)

  vim.keymap.set("i", "<C-k>", function()
    vim.lsp.buf.signature_help()
  end, default_opts)

  vim.keymap.set("n", "<Leader>wa", function()
    vim.lsp.buf.add_workspace_folder()
  end, default_opts)

  vim.keymap.set("n", "<Leader>wr", function()
    vim.lsp.buf.remove_workspace_folder()
  end, default_opts)

  vim.keymap.set("n", "<Leader>wl", function()
    vim.pretty_print(vim.lsp.buf.list_workspace_folders())
  end, default_opts)

  vim.keymap.set("n", "<Leader>D", function()
    vim.lsp.buf.type_definition()
  end, default_opts)

  vim.keymap.set("n", "<Leader>rn", function()
    vim.lsp.buf.rename()
  end, default_opts)

  vim.keymap.set("n", "gr", function()
    vim.lsp.buf.references()
  end, default_opts)

  vim.keymap.set("n", "<Leader>d", function()
    vim.diagnostic.open_float()
  end, default_opts)

  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
  end, default_opts)

  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next()
  end, default_opts)

  vim.keymap.set("n", "<Leader>q", function()
    vim.diagnostic.set_loclist()
  end, default_opts)
end

return M
