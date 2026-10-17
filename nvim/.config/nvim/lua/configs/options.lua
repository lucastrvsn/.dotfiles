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

-- general
vim.g.mapleader = " " -- map leader key to space
vim.o.mouse = "nvh" -- enable mouse support in normal, visual and insert modes
vim.o.undofile = true -- enable persistent undo
vim.o.history = 10000 -- set command history to 10k
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- UI
vim.o.title = true -- enable window title
vim.o.titlestring = "%<%F - nvim" -- set the title format
vim.o.breakindent = true -- indent wrapped lines to match line start
vim.o.breakindentopt = "list:-1" -- add padding for lists (if `wrap` is set)
vim.o.cursorline = true -- enable current line highlighting
vim.o.scrolloff = 4 -- minimum number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 4 -- minimum number of screen columns to keep to the left and right of the cursor

vim.o.equalalways = true -- always make splits equal
vim.o.splitbelow = true -- force all horizontal splits to go below
vim.o.splitright = true -- force all vertical splits to go to the right

vim.o.foldlevel = 10 -- no fold by default
vim.o.foldmethod = "indent" -- fold based on indent level
vim.o.foldnestmax = 10 -- limit number of fold levels
vim.o.foldtext = "" -- show text under fold with its highlighting

-- settings
vim.o.complete = ".,w,b,kspell" -- Use less sources
vim.o.completeopt = "menuone,noselect,fuzzy,nosort" -- Use custom behavior
vim.o.completetimeout = 100 -- Limit sources delay

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
vim.opt.pumblend = 0
vim.opt.winblend = 0
vim.opt.pumheight = 14
vim.opt.signcolumn = "yes:1"
vim.opt.list = true
vim.opt.listchars = vim.opt.listchars
  + "nbsp:⦸"
  + "tab:> "
  + "extends:…"
  + "precedes:…"
  + "lead:·"
  + "trail:␠"
vim.opt.fillchars = {
  eob = "~",
  fold = "·",
  horiz = "━",
  horizdown = "┳",
  horizup = "┻",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 50
vim.opt.showtabline = 1
vim.opt.showmode = true
vim.opt.laststatus = 3
vim.opt.path:append "**"
vim.opt.shortmess = vim.opt.shortmess
  + "A" -- ignore annoying swapfile messages
  + "I" -- no spash screen
  + "O" -- file-read message overrites previous
  + "T" -- truncate non-file messages in middle
  + "W" -- dont echo '[w]/[written]' when writing
  + "a" -- use abbreviations in message '[ro]' instead of '[readonly]'
  + "o" -- overwrite file-written mesage
  + "t" -- truncate file messages at start
  + "c" -- dont show matching messages
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.wildoptions = "fuzzy,pum,tagfile"
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
vim.opt.synmaxcol = 120
vim.opt.formatoptions = "njvcrql"
vim.opt.joinspaces = false
vim.opt.ttyfast = true

-- colors
vim.opt.termguicolors = true
vim.opt.background = "dark"
