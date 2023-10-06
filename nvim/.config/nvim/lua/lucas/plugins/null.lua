local null = require "null-ls"

null.setup {
  debug = true,
  sources = {
    -- actions
    null.builtins.code_actions.eslint_d,

    -- diagnostics
    null.builtins.diagnostics.eslint_d,
    null.builtins.diagnostics.selene,
    null.builtins.diagnostics.stylelint,
    null.builtins.diagnostics.ruff,

    -- formatters
    null.builtins.formatting.eslint_d,
    null.builtins.formatting.gofmt,
    null.builtins.formatting.rustfmt.with {
      extra_args = { "--edition=2021" },
    },
    null.builtins.formatting.stylua,
    null.builtins.formatting.stylelint,
    null.builtins.formatting.ruff,
  },
}
