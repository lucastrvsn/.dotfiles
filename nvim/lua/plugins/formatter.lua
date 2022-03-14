-- I will use this until formatting from LSP is stable.

local prettier = function()
  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      "--single-quote",
    },
    stdin = true,
  }
end

local prettier_eslint = function()
  return {
    exe = "prettier-eslint",
    args = {
      "--stdin",
      "--stdin-filepath",
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
    },
    stdin = true,
  }
end

local rustfmt = function()
  return {
    exe = "rustfmt",
    args = {
      "--emit=stdout",
    },
    stdin = true,
  }
end

local stylua = function()
  return {
    exe = "stylua",
    args = {
      "--search-parent-directories",
      "-",
    },
    stdin = true,
  }
end

require("formatter").setup {
  logging = false,
  filetype = {
    javascript = {
      prettier_eslint,
    },
    javascriptreact = {
      prettier_eslint,
    },
    typescript = {
      prettier_eslint,
    },
    typescriptreact = {
      prettier_eslint,
    },
    css = {
      prettier,
    },
    less = {
      prettier,
    },
    sass = {
      prettier,
    },
    scss = {
      prettier,
    },
    json = {
      prettier,
    },
    graphql = {
      prettier,
    },
    markdown = {
      prettier,
    },
    vue = {
      prettier,
    },
    yaml = {
      prettier,
    },
    html = {
      prettier,
    },
    rust = {
      rustfmt,
    },
    lua = {
      stylua,
    },
  },
}

vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.rs,*.lua FormatWrite
augroup END
]],
  true
)
