local now, later = MiniDeps.now, MiniDeps.later

now(function()
  require("mini.icons").setup {
    lsp = {
      copilot = {
        glyph = "",
        hl = "MiniIconsGrey",
      },
    },
  }
end)

now(function()
  require("mini.files").setup {
    content = {
      filter = nil,
      prefix = nil,
      sort = nil,
    },
    mappings = {
      close = "q",
      go_in = "l",
      go_in_plus = "L",
      go_out = "h",
      go_out_plus = "H",
      mark_goto = "'",
      mark_set = "m",
      reset = "<BS>",
      reveal_cwd = "@",
      show_help = "g?",
      synchronize = "=",
      trim_left = "<",
      trim_right = ">",
    },
    options = {
      permanent_delete = true,
      use_as_default_explorer = true,
    },
    windows = {
      max_number = math.huge,
      preview = false,
      width_focus = 50,
      width_nofocus = 15,
      width_preview = 25,
    },
  }
end)

-- now(function()
--   local MiniStatusline = require "mini.statusline"
--
--   MiniStatusline.setup {
--     content = {
--       active = function()
--         local filename = MiniStatusline.section_filename { trunc_width = 140 }
--         local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
--
--         return MiniStatusline.combine_groups {
--           "%<", -- Mark general truncate point
--           { hl = "MiniStatuslineFilename", strings = { filename } },
--           "%=", -- End left alignment
--           { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
--         }
--       end,
--       inactive = nil,
--     },
--     use_icons = false,
--   }
-- end)

later(function()
  require("mini.comment").setup {}
end)

later(function()
  require("mini.diff").setup {
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "▎",
      },
    },
  }
end)

later(function()
  require("mini.pick").setup {
    mappings = {
      caret_left = "<Left>",
      caret_right = "<Right>",

      choose = "<CR>",
      choose_in_split = "<C-s>",
      choose_in_tabpage = "<C-t>",
      choose_in_vsplit = "<C-v>",
      choose_marked = "<M-CR>",

      delete_char = "<BS>",
      delete_char_right = "<Del>",
      delete_left = "<C-u>",
      delete_word = "<C-w>",

      mark = "<C-x>",
      mark_all = "<C-a>",

      move_down = "<C-j>",
      move_start = "<C-g>",
      move_up = "<C-k>",

      paste = "<C-r>",

      refine = "<C-Space>",
      refine_marked = "<M-Space>",

      scroll_down = "<C-f>",
      scroll_left = "<C-h>",
      scroll_right = "<C-l>",
      scroll_up = "<C-b>",

      stop = "<Esc>",

      toggle_info = "<S-Tab>",
      toggle_preview = "<Tab>",
    },
    window = {
      prompt_carret = "▏",
      prompt_prefix = "/ ",
    },
  }
end)

later(function()
  require("mini.surround").setup {}
end)
