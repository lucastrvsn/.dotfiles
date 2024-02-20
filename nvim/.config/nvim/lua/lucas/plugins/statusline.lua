local MiniStatusline = require "mini.statusline"

MiniStatusline.setup {
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local diagnostics =
        MiniStatusline.section_diagnostics { trunc_width = 75 }
      local filename = MiniStatusline.section_filename { trunc_width = 140 }

      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
      }
    end,
    inactive = nil,
  },
  use_icons = true,
}
