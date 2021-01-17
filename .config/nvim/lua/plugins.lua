-- gitsigns
require('gitsigns').setup({
  signs = {
    add          = { hl = 'DiffAdd'   , text = '+' },
    change       = { hl = 'DiffChange', text = '+' },
    delete       = { hl = 'DiffDelete', text = '-' },
    topdelete    = { hl = 'DiffDelete', text = '-' },
    changedelete = { hl = 'DiffChange', text = '~' },
  }
})

-- formatter.nvim
local prettier = function()
  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      vim.api.nvim_buf_get_name(0),
      "--single-quote"
    },
    stdin = true
  }
end

local rustfmt = function()
  return {
    exe = "rustfmt",
    args = {
      "--emit=stdout"
    },
    stdin = true
  }
end

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
      prettier
    },
    javascriptreact = {
      prettier
    },
    typescript = {
      prettier
    },
    typescriptreact = {
      prettier
    },
    css = {
      prettier
    },
    less = {
      prettier
    },
    sass = {
      prettier
    },
    scss = {
      prettier
    },
    json = {
      prettier
    },
    graphql = {
      prettier
    },
    markdown = {
      prettier
    },
    vue = {
      prettier
    },
    yaml = {
      prettier
    },
    html = {
      prettier
    },
    rust = {
      rustfmt
    }
  }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.rs FormatWrite
augroup END
]], true)

