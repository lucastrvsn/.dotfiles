-- map leader to space
vim.g.mapleader = " "

-- disable builtin plugins
vim.g.loaded_2html_plugin = true
vim.g.loaded_getscript = true
vim.g.loaded_getscriptPlugin = true
vim.g.loaded_gzip = true
vim.g.loaded_logiPat = true
vim.g.loaded_matchit = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwFileHandlers = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_netrwSettings = true
vim.g.loaded_rrhelper = true
vim.g.loaded_tar = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_vimball = true
vim.g.loaded_vimballPlugin = true
vim.g.loaded_zip = true
vim.g.loaded_zipPlugin = true

-- settings
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
vim.opt.cmdheight = 0
vim.opt.ruler = true
vim.opt.completeopt = {
  "menu",
  "menuone",
  "noselect",
}
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 4
-- vim.opt.smoothscroll = true
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
vim.opt.relativenumber = false
vim.opt.equalalways = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.pumblend = 8
vim.opt.winblend = 8
vim.opt.pumheight = 14
vim.opt.signcolumn = "yes:1"
vim.opt.list = true
vim.opt.listchars = {
  tab = "‣‣",
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
vim.opt.laststatus = 2
vim.opt.path:append "**"
vim.opt.shortmess:append "c"
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.wildoptions = "pum,tagfile"
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
vim.opt.colorcolumn = "80,120"
vim.opt.synmaxcol = 240
vim.opt.formatoptions = "njvcrql"
vim.opt.joinspaces = false

-- fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- colors
vim.opt.termguicolors = true
vim.opt.background = "dark"
