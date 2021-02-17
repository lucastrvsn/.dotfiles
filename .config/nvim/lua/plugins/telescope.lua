local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<Esc>"]  = actions.close,
        ["<C-n>"]  = actions.move_selection_next,
        ["<C-p>"]  = actions.move_selection_previous,
        ["<C-j>"]  = actions.move_selection_next,
        ["<C-k>"]  = actions.move_selection_previous,
        ["<C-c>"]  = actions.close,
        ["<Down>"] = false,
        ["<Up>"]   = false,
        ["<CR>"]   = actions.goto_file_selection_edit + actions.center,
        ["<C-x>"]  = actions.goto_file_selection_split,
        ["<C-v>"]  = actions.goto_file_selection_vsplit,
        ["<C-t>"]  = actions.goto_file_selection_tabedit,
        ["<C-u>"]  = actions.preview_scrolling_up,
        ["<C-d>"]  = actions.preview_scrolling_down,
      },
      n = {
        ["<Esc>"]  = actions.close,
        ["<CR>"]   = actions.goto_file_selection_edit + actions.center,
        ["<C-x>"]  = actions.goto_file_selection_split,
        ["<C-v>"]  = actions.goto_file_selection_vsplit,
        ["<C-t>"]  = actions.goto_file_selection_tabedit,
        ["j"]      = actions.move_selection_next,
        ["k"]      = actions.move_selection_previous,
        ["<Down>"] = false,
        ["<Up>"]   = false,
        ["<C-u>"]  = actions.preview_scrolling_up,
        ["<C-d>"]  = actions.preview_scrolling_down,
      }
    },
    file_ignore_patterns = {
      '.git/*',
      'node_modules/*',
      'bower_components/*',
      '.svn/*',
      '.hg/*',
      'CVS/*',
      '.next/*',
      '.docz/*',
      '.DS_Store'
    },
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
    winblend = 20,
    width = 0.65,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8
  }
}

local options = {
  noremap = true
}

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>g', '<cmd>lua require("telescope.builtin").live_grep()<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>b', '<cmd>lua require("telescope.builtin").buffers()<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>t', '<cmd>lua require("telescope.builtin").help_tags()<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>rf', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', options)
