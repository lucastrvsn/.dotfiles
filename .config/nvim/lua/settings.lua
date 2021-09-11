-- map leader to space
vim.g.mapleader = " "

-- disable builtin plugins
vim.g.loaded_gzip = true
vim.g.loaded_tar = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_zip = true
vim.g.loaded_zipPlugin = true
vim.g.loaded_getscript = true
vim.g.loaded_getscriptPlugin = true
vim.g.loaded_vimball = true
vim.g.loaded_vimballPlugin = true
vim.g.loaded_matchit = true
vim.g.loaded_2html_plugin = true
vim.g.loaded_logiPat = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_rrhelper = true
vim.g.loaded_netrwSettings = true
vim.g.loaded_netrwFileHandlers = true

vim.opt.compatible = false
vim.opt.mouse = "nvh"
vim.opt.history = 10000
vim.opt.backup = true
vim.opt.backupdir = "/tmp//,."
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undodir = "/tmp//,."
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.updatetime = 500
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.ruler = true
vim.opt.completeopt = {
  "menuone",
  "noinsert",
  "noselect",
}
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.incsearch = true
vim.opt.inccommand = "nosplit"
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.gdefault = true
vim.opt.hidden = true
vim.opt.wrap = false
vim.opt.backspace = {
  "indent",
  "eol",
  "start",
}
vim.opt.display = "lastline"
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.magic = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.equalalways = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.pumblend = 8
vim.opt.winblend = 8
vim.opt.pumheight = 14
vim.opt.signcolumn = "yes:1"
vim.opt.list = true
vim.opt.listchars = {
  tab = "➞ ",
  lead = "·",
  trail = "·",
}
vim.opt.fillchars = {
  eob = "~",
}
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 50
vim.opt.showtabline = 0
vim.opt.showmode = false
vim.opt.path:append "**"
vim.opt.shortmess:append "c"
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildoptions = "pum"
vim.opt.wildignore:append {
  "*/.git/*",
  "*/.hg/*",
  "*/.svn/*.",
  "*/.vscode/*.",
  "*/.DS_Store",
  "*/dist*/*",
  "*/target/*",
  "*/builds/*",
  "*/build/*",
  "tags",
  "*/lib/*",
  "*/flow-typed/*",
  "*/node_modules/*",
  "*.png",
  "*.PNG",
  "*.jpg",
  "*.jpeg",
  "*.JPG",
  "*.JPEG",
  "*.pdf",
  "*.exe",
  "*.o",
  "*.obj",
  "*.dll",
  "*.DS_Store",
  "*.ttf",
  "*.otf",
  "*.woff",
  "*.woff2",
  "*.eot",
}
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.autoread = true
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.showmatch = true
vim.opt.colorcolumn = "80"
vim.opt.synmaxcol = 1024
vim.opt.formatoptions = "njvcrql"
vim.opt.joinspaces = false

-- fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99

-- highlight on yank
vim.cmd 'au TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })'

-- some terminal escape sequence
vim.cmd 'let &t_Cs = "e[4:3m"'
vim.cmd 'let &t_Ce = "e[4:0m"'
