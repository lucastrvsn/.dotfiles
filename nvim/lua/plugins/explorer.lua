local dirbuf = require "dirbuf"

dirbuf.setup {
  hash_padding = 2,
  show_hidden = true,
  sort_order = "directories_first",
  write_cmd = "DirbufSync",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dirbuf",
  callback = function(args)
    local buffer_number = args.buf

    vim.keymap.set("n", "<C-v>", function()
      dirbuf.enter "vsplit"
    end, {
      silent = true,
      buffer = buffer_number,
    })
    vim.keymap.set("n", "<C-s>", function()
      dirbuf.enter "split"
    end, {
      silent = true,
      buffer = buffer_number,
    })
    vim.keymap.set("n", "<C-t>", function()
      dirbuf.enter "tabedit"
    end, {
      silent = true,
      buffer = buffer_number,
    })
  end,
})
