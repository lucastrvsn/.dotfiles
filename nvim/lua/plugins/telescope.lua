local actions = require "telescope.actions"

local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

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
        ["<Down>"] = false,
        ["<Up>"] = false,
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
        ["<Down>"] = false,
        ["<Up>"] = false,
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
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
    },
    git_files = {
      theme = "dropdown",
      previewer = false,
    },
    live_grep = {
      theme = "dropdown",
      previewer = false,
    },
    file_browser = {
      theme = "dropdown",
      previewer = false,
    },
  },
}

vim.api.nvim_set_keymap(
  "n",
  "<C-p>",
  '<cmd>lua require("plugins/telescope").project_files()<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<Leader>g",
  '<cmd>lua require("telescope.builtin").live_grep()<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<Leader>b",
  '<cmd>lua require("telescope.builtin").buffers()<CR>',
  { noremap = true, silent = true }
)

return M
