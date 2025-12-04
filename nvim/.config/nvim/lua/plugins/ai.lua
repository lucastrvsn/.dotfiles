local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add {
    source = "ravitemer/mcphub.nvim",
    depends = {
      "nvim-lua/plenary.nvim",
    },
    -- hooks = {
    --   post_checkout = function()
    --     vim
    --       .system({ "npm", "install", "-g", "mcp-hub@latest" }, { text = true })
    --       :wait()
    --   end,
    -- },
  }

  require("mcphub").setup {}
end)

later(function()
  add {
    source = "zbirenbaum/copilot.lua",
  }

  require("copilot").setup {
    suggestion = {
      enabled = false,
    },
    panel = {
      enabled = false,
    },
    copilot_model = "gemini-3-pro-preview",
  }
end)

later(function()
  add {
    source = "olimorris/codecompanion.nvim",
    depends = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  }

  require("codecompanion").setup {
    strategies = {
      chat = {
        adapter = "copilot",
        model = "gemini-3-pro-preview",
      },
      inline = {
        adapter = "copilot",
        model = "gemini-3-pro-preview",
      },
      cmd = {
        adapter = "copilot",
        model = "gemini-3-pro-preview",
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_tools = true,
          show_server_tools_in_chat = true,
          add_mcp_prefix_to_tool_names = false,
          show_result_in_chat = true,
          format_tool = nil,
          make_vars = true,
          make_slash_commands = true,
        },
      },
    },
  }

  vim.keymap.set("n", "<Leader>cc", "<Cmd>CodeCompanionChat Toggle<CR>", {
    desc = "Toggle CodeCompanion chat window",
  })
  vim.keymap.set("n", "<Leader>ca", "<Cmd>CodeCompanionActions<CR>", {
    desc = "Open CodeCompanion actions picker",
  })
end)
