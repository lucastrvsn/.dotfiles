local MiniFiles = require "mini.files"

MiniFiles.setup {
  content = {
    prefix = function() end,
  },
  mappings = {
    go_in = "<S-CR>",
    go_in_plus = "<CR>",
    go_out = "-",
    go_out_plus = "_",
  },
}

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowOpen",
  callback = function(args)
    local win_id = args.data.win_id

    vim.api.nvim_win_set_config(win_id, {
      border = "shadow",
    })
  end,
})

vim.keymap.set("n", "-", function()
  if MiniFiles.get_target_window() == nil then
    local current = vim.api.nvim_buf_get_name(0)
    MiniFiles.open(current)
  end
end)
