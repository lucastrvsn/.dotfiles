local add, later = MiniDeps.add, MiniDeps.later

later(function()
  local function get_kind_icon_text(ctx)
    local icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
    return icon
  end

  local function get_kind_icon_hl(ctx)
    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
    return hl
  end

  add {
    source = "saghen/blink.cmp",
    checkout = "v1.10.1",
    depends = {
      "rafamadriz/friendly-snippets",
      "fang2hou/blink-copilot",
    },
  }

  require("blink.cmp").setup {
    sources = {
      default = {
        "lsp",
        "path",
        "copilot",
        "snippets",
        "buffer",
      },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
          opts = {
            max_completions = 1,
          },
        },
      },
    },
    fuzzy = {
      implementation = "prefer_rust",
      sorts = {
        -- "exact",
        "score",
        "sort_text",
      },
    },
    completion = {
      ghost_text = {
        enabled = false,
      },
      menu = {
        border = "shadow",
        draw = {
          components = {
            kind_icon = {
              text = get_kind_icon_text,
              highlight = get_kind_icon_hl,
            },
            kind = {
              highlight = get_kind_icon_hl,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
      },
    },
    signature = {
      enabled = true,
    },
    keymap = {
      -- remove default keymaps
      preset = "none",

      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        "snippet_forward",
        "select_next",
        "fallback",
      },
      ["<S-Tab>"] = {
        "snippet_backward",
        "select_prev",
        "fallback",
      },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback_to_mappings" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback_to_mappings" },
      ["<C-k>"] = {
        "show_signature",
        "hide_signature",
        "fallback",
      },
    },
  }
end)
