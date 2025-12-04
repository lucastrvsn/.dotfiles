local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add {
    source = "stevearc/oil.nvim",
  }

  require("oil").setup {
    default_file_explorer = true,
    columns = {
      { "mtime", highlight = "Comment" },
      { "size", highlight = "Comment" },
      { "icon", add_padding = false },
    },
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
      timeout_ms = 1000,
      autosave_changes = false,
    },
    constrain_cursor = "editable",
    experimental_watch_for_changes = false,
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = false,
      ["<C-h>"] = false,
      ["<C-t>"] = false,
      ["<C-p>"] = false,
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
    view_options = {
      show_hidden = true,
      natural_order = true,
      case_insensitive = true,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
    },
    ssh = {
      border = "rounded",
    },
    keymaps_help = {
      border = "rounded",
    },
  }

  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end)
