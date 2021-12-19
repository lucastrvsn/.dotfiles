local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

local prettier_eslint = helpers.make_builtin {
  method = {
    methods.internal.FORMATTING,
    methods.internal.RANGE_FORMATTING,
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "json",
  },
  generator_opts = {
    command = "prettier-eslint",
    args = helpers.range_formatting_args_factory {
      "--stdin",
      "--stdin-filepath",
      "$FILENAME"
    },
    to_stdin = true,
  },
  factory = helpers.formatter_factory,
}

require("null-ls").config {
  sources = {
    -- diagnostics
    require("null-ls").builtins.diagnostics.eslint_d,

    -- formatters
    require("null-ls").builtins.formatting.stylua,

    -- custom formatters
    prettier_eslint,
  },
}
