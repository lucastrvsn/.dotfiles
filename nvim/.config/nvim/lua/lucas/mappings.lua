-- moving up and down the right way
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })

-- disable dead keys
vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Right>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "Q", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-z>", "<Nop>", { noremap = true, silent = true })

-- save as root
vim.keymap.set(
  "c",
  "w!!",
  "w !sudo tee % >/dev/null<CR>:e!<CR><CR>",
  { noremap = true }
)

-- open vim config
vim.keymap.set("n", "<Leader>rc", ":e $MYVIMRC<CR>", { noremap = true })

-- keep visual selection when indenting
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- deal with clipboard
vim.keymap.set("n", "<Leader>y", '"+y', { noremap = true })
vim.keymap.set("v", "<Leader>y", '"+y', { noremap = true })
vim.keymap.set("n", "<Leader>p", '"+p', { noremap = true })
vim.keymap.set("v", "<Leader>p", '"+p', { noremap = true })
vim.keymap.set("n", "<Leader>P", '"+P', { noremap = true })

-- buffer navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })
vim.keymap.set("n", "<Leader>,", "<C-^>", { noremap = true })
vim.keymap.set("n", "<Leader>ls", ":buffers<CR>", { noremap = true })

-- search and replace the word under cursor
vim.keymap.set("n", "*", ":%s/<C-r><C-w>//<Left>", { noremap = true })

-- snippets
-- vim.keymap.set({ "i", "s" }, "<Tab>", function()
--   if vim.snippets.jumpable(1) then
--     return "<Cmd>lua vim.snippets.jump(1)<CR>"
--   end
--
--   return "<Tab>"
-- end, { expr = true })
--
-- vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
--   if vim.snippets.jumpable(-1) then
--     return "<Cmd>lua vim.snippets.jump(-1)<CR>"
--   end
--
--   return "<S-Tab>"
-- end, { expr = true })
