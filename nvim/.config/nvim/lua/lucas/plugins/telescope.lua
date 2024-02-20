local M = {}

function M.find_files()
  local opts = {
    cwd = vim.loop.os_homedir(),
  }

  local root_dirs = require("lucas.plugins.lsp.utils").get_root_dirs()

  if vim.tbl_count(root_dirs) > 0 then
    opts.search_dirs = root_dirs
  else
    root_dirs = vim.fs.find({ ".git" }, {
      type = "directory",
      upward = true,
      path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
      stop = opts.cwd,
    })

    if vim.tbl_count(root_dirs) > 0 then
      opts.search_dirs = root_dirs
    end
  end

  require("telescope.builtin").find_files(opts)
end

function M.live_grep()
  local opts = {
    cwd = vim.loop.os_homedir(),
  }

  local root_dirs = require("lucas.plugins.lsp.utils").get_root_dirs()

  if vim.tbl_count(root_dirs) > 0 then
    opts.search_dirs = root_dirs
  else
    root_dirs = vim.fs.find({ ".git" }, {
      type = "directory",
      upward = true,
      path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
      stop = opts.cwd,
    })

    if vim.tbl_count(root_dirs) > 0 then
      opts.search_dirs = root_dirs
    end
  end

  require("telescope.builtin").live_grep(opts)
end

local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    prompt_prefix = "/ ",
    selection_caret = "> ",
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<Up>"] = actions.move_selection_previous,
        ["<Down>"] = actions.move_selection_next,
        ["<CR>"] = actions.select_default + actions.center,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
      },
      n = {
        ["<Esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["<Up>"] = actions.move_selection_previous,
        ["<Down>"] = actions.move_selection_next,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
      },
    },
    file_ignore_patterns = {
      ".git/*",
      "node_modules/*",
      "bower_components/*",
      ".svn/*",
      ".hg/*",
      "CVS/*",
      ".next/*",
      ".docz/*",
      ".DS_Store",
    },
    layout_strategy = "flex",
    scroll_strategy = "cycle",
    layout_config = {
      prompt_position = "bottom",
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
    },
  },
}

vim.keymap.set(
  "n",
  "<C-p>",
  '<cmd>lua require("lucas.plugins.telescope").find_files()<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<Leader>g",
  '<cmd>lua require("lucas.plugins.telescope").live_grep()<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<Leader>b",
  '<cmd>lua require("telescope.builtin").buffers()<CR>',
  { noremap = true, silent = true }
)

return M
