local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add {
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    hooks = {
      post_checkout = function()
        vim.cmd "TSUpdate"
      end,
    },
  }

  require("nvim-treesitter").install {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "csv",
    "dockerfile",
    "editorconfig",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "glsl",
    "go",
    "gomod",
    "gosum",
    "graphql",
    "hlsl",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "jsx",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "nginx",
    "objc",
    "prisma",
    "python",
    "regex",
    "robots_txt",
    "rust",
    "scss",
    "sql",
    "ssh_config",
    "swift",
    "terraform",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "wgsl",
    "xml",
    "yaml",
    "zsh",
  }

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(evt)
      local filetype = evt.match
      local lang = vim.treesitter.language.get_lang(filetype)

      if vim.treesitter.language.add(lang) then
        vim.treesitter.start(evt.buf)

        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end)
