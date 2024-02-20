local cmp = require "cmp"

local icons = {
  Text = "⌗",
  Method = "ƒ",
  Function = "ƒ",
  Constructor = "ƒ",
  Field = "🝆",
  Variable = "🝆",
  Class = "∗",
  Interface = "∗",
  Module = "◇",
  Property = "🝆",
  Unit = "🝆",
  Value = "🝆",
  Enum = "∗",
  Keyword = "ℹ",
  Snippet = "ℹ",
  Color = "ℹ",
  File = "⌗",
  Reference = "∗",
  Folder = "⌗",
  EnumMember = "∗",
  Constant = "∗",
  Struct = "∗",
  Event = "ℹ",
  Operator = "ℹ",
  TypeParameter = "ℹ",
}

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
  }, {
    { name = "buffer" },
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
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

      if vim.snippet.jumpable(1) then
        return vim.snippet.jump(1)
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

      if vim.snippet.jumpable(-1) then
        return vim.snippet.jump(-1)
      end

      return fallback()
    end,
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
  formatting = {
    format = function(entry, item)
      item.kind = icons[item.kind]

      item.menu = ({
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        nvim_lua = "[lua]",
      })[entry.source.name]

      return item
    end,
  },
}
