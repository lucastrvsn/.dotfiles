local setup = require("cmp").setup
local config = require("cmp").config
local mapping = require("cmp").mapping

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match "%s"
      == nil
end

setup {
  sources = config.sources({
    { name = "nvim_lsp" },
    { name = "snippy" },
  }, {
    { name = "buffer" },
  }),
  snippet = {
    expand = function(args)
      require("snippy").expand_snippet(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = mapping(mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = mapping(mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = mapping.confirm {
      behavior = require("cmp").ConfirmBehavior.Insert,
      select = true,
    },
    ["<Tab>"] = function(fallback)
      if not require("cmp").select_next_item() then
        if vim.bo.buftype ~= "prompt" and has_words_before() then
          require("cmp").complete()
        else
          fallback()
        end
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if not require("cmp").select_prev_item() then
        if vim.bo.buftype ~= "prompt" and has_words_before() then
          require("cmp").complete()
        else
          fallback()
        end
      end
    end,
    ["<C-e>"] = mapping {
      i = mapping.abort(),
      c = mapping.close(),
    },
    ["<CR>"] = mapping.confirm { select = true },
  },
}

setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})
