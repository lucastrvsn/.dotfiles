local cmp = require "cmp"
local snippy = require "snippy"

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))

  return col ~= 0
    and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match "%s"
      == nil
end

cmp.setup {
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "snippy" },
  }, {
    { name = "buffer" },
  }),
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        return cmp.select_next_item()
      end

      if snippy.can_expand_or_advance() then
        return snippy.expand_or_advance()
      end

      if has_words_before() then
        return cmp.complete()
      end

      return fallback()
    end, { "i", "s" }),
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        return cmp.select_prev_item()
      end

      if snippy.can_jump(-1) then
        return snippy.previous()
      end

      return fallback()
    end,
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
}

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})
