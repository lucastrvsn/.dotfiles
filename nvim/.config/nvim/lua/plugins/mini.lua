local now, later = MiniDeps.now, MiniDeps.later

now(function()
  local MiniIcons = require "mini.icons"

  MiniIcons.setup {
    lsp = {
      copilot = {
        glyph = "",
        hl = "MiniIconsGrey",
      },
    },
  }
end)

now(function()
  local MiniMisc = require "mini.misc"

  MiniMisc.setup()

  -- Change current working directory based on the current file path. It
  -- searches up the file tree until the first root marker ('.git' or 'Makefile')
  -- and sets their parent directory as a current directory.
  -- This is helpful when simultaneously dealing with files from several projects.
  MiniMisc.setup_auto_root()

  -- Restore latest cursor position on file open
  MiniMisc.setup_restore_cursor()

  -- Synchronize terminal emulator background with Neovim's background to remove
  -- possibly different color padding around Neovim instance
  MiniMisc.setup_termbg_sync()
end)

now(function()
  -- local MiniCompletion = require "mini.completion"
  --
  -- -- Customize post-processing of LSP responses for a better user experience.
  -- -- Don't show 'Text' suggestions (usually noisy) and show snippets last.
  -- local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  -- local process_items = function(items, base)
  --   return MiniCompletion.default_process_items(items, base, process_items_opts)
  -- end
  --
  -- MiniCompletion.setup {
  --   lsp_completion = {
  --     -- Without this config autocompletion is set up through `:h 'completefunc'`.
  --     -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
  --     -- (sets up only when needed) and makes it possible to use `<C-u>`.
  --     source_func = "omnifunc",
  --     auto_setup = false,
  --     process_items = process_items,
  --   },
  -- }
  --
  -- -- Set 'omnifunc' for LSP completion only when needed.
  -- local on_attach = function(ev)
  --   vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
  -- end
  --
  -- local gr = vim.api.nvim_create_augroup("lucastrvsn.config", {})
  -- vim.api.nvim_create_autocmd("LspAttach", {
  --   group = gr,
  --   callback = on_attach,
  --   desc = "Set 'omnifunc' for LSP completion",
  -- })
  --
  -- -- Advertise to servers that Neovim now supports certain set of completion and
  -- -- signature features through 'mini.completion'.
  -- vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

now(function()
  -- local MiniFiles = require "mini.files"
  --
  -- MiniFiles.setup {
  --   content = {
  --     filter = nil,
  --     prefix = nil,
  --     sort = nil,
  --   },
  --   mappings = {
  --     close = "q",
  --     go_in = "l",
  --     go_in_plus = "L",
  --     go_out = "h",
  --     go_out_plus = "H",
  --     mark_goto = "'",
  --     mark_set = "m",
  --     reset = "<BS>",
  --     reveal_cwd = "@",
  --     show_help = "g?",
  --     synchronize = "=",
  --     trim_left = "<",
  --     trim_right = ">",
  --   },
  --   options = {
  --     permanent_delete = true,
  --     use_as_default_explorer = true,
  --   },
  --   windows = {
  --     max_number = math.huge,
  --     preview = false,
  --     width_focus = 50,
  --     width_nofocus = 15,
  --     width_preview = 25,
  --   },
  -- }
end)

now(function()
  local MiniStatusline = require "mini.statusline"

  MiniStatusline.setup {
    use_icons = true,
    content = {
      active = function()
        -- local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
        local filename = MiniStatusline.section_filename { trunc_width = 140 }
        local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }

        return MiniStatusline.combine_groups {
          -- { hl = mode_hl, strings = { mode } },
          "%<",
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=",
          -- { hl = "MiniStatuslineSearchCount", strings = { fileinfo } },
          { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        }
      end,
      inactive = nil,
    },
  }
end)

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
      prompt_caret = "▏",
      prompt_prefix = "/ ",
    },
  }
end)

later(function()
  require("mini.surround").setup {}
end)
