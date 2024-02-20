require("lspconfig").denols.setup {
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function ()
        vim.lsp.buf.format {
          bufnr = bufnr,
        }
      end
    })
  end,
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}
