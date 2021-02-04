local map = require('utils').map

-- moving up and down the right way
map('n', 'j', 'gj', { noremap = true, silent = true })
map('n', 'k', 'gk', { noremap = true, silent = true })

-- disable dead keys
map('n', '<Up>', '<Nop>', { noremap = true, silent = true })
map('n', '<Down>', '<Nop>', { noremap = true, silent = true })
map('n', '<Left>', '<Nop>', { noremap = true, silent = true })
map('n', '<Right>', '<Nop>', { noremap = true, silent = true })
map('i', '<Up>', '<Nop>', { noremap = true, silent = true })
map('i', '<Down>', '<Nop>', { noremap = true, silent = true })
map('i', '<Left>', '<Nop>', { noremap = true, silent = true })
map('i', '<Right>', '<Nop>', { noremap = true, silent = true })
map('n', 'Q', '<Nop>', { noremap = true, silent = true })
map('n', '<C-z>', '<Nop>', { noremap = true, silent = true })

-- save as root
map('c', 'w!!', 'w !sudo tee % >/dev/null<CR>:e!<CR><CR>')

-- open vim config
map('n', '<Leader>rc', ':e $MYVIMRC<CR>', { noremap = true })

-- keep visual selection when indenting
map('v', '<', '<gv', { noremap = true, silent = true })
map('v', '>', '>gv', { noremap = true, silent = true })

-- deal with clipboard
map('n', '<Leader>y', '"+y')
map('v', '<Leader>y', '"+y')
map('n', '<Leader>p', '"+p')
map('v', '<Leader>p', '"+p')
map('n', '<Leader>P', '"+P')

-- buffer navigation
map('n', '<Leader>,', '<C-^>')
map('n', '<Leader>ls', ':buffers<CR>')
map('n', 'gb', ':bnext<CR>')
map('n', 'gB', ':bprev<CR>')

-- search and replace the word under cursor
map('n', '<Leader>*', ':%s/<C-r><C-w>//<Left>')

