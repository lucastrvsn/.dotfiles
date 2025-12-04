local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add {
    source = "saghen/blink.cmp",
    checkout = "v1.4.1",
    depends = {
      "rafamadriz/friendly-snippets",
      "fang2hou/blink-copilot",
    },
  }

  require("blink.cmp").setup {
    sources = {
      default = {
        "lsp",
        "buffer",
        "snippets",
        "copilot",
      },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          -- score_offset = 100,
          async = true,
        },
      },
    },
    completion = {
      ghost_text = {
        enabled = false,
      },
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon, _, _ = require("mini.icons").get("lsp", ctx.kind)

                return icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)

                return hl
              end,
            },
            kind = {
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)

                return hl
              end,
            },
          },
        },
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
        max_items = 8,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 800,
      },
    },
    signature = {
      enabled = true,
    },
    keymap = {
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
      ["<C-n>"] = {
        "select_next",
        "fallback_to_mappings",
      },
      ["<C-p>"] = {
        "select_prev",
        "fallback_to_mappings",
      },
      ["<C-Space>"] = {
        "show",
        "show_documentation",
        "hide_documentation",
      },
      ["<C-e>"] = { "hide" },
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
