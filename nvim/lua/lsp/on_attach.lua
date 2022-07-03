local lsp_format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return function(client, bufnr)
  vim.diagnostic.config {
    float = {
      scope = "cursor",
    },
    underline = false,
    update_in_insert = true,
  }

  vim.api.nvim_set_keymap(
    "n",
    "gD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "gd",
    "<cmd>lua vim.lsp.buf.definition()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "K",
    "<cmd>lua vim.lsp.buf.hover()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "gi",
    "<cmd>lua vim.lsp.buf.implementation()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>k",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "i",
    "<C-k>",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>wa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>wr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>D",
    "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<space>rn",
    "<cmd>lua vim.lsp.buf.rename()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "gr",
    "<cmd>lua vim.lsp.buf.references()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>d",
    "<cmd>lua vim.diagnostic.open_float()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "[d",
    "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "]d",
    "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>q",
    "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
    { noremap = true, silent = true }
  )

  vim.api.nvim_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- auto format files on save
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds {
      group = lsp_format_augroup,
      buffer = bufnr,
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = lsp_format_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          filter = function(c)
              return c.name == "null-ls"
          end,
          bufnr = bufnr,
          async = false,
        }
      end,
    })
  end
end
