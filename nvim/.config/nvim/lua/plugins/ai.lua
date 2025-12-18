local add, later = MiniDeps.add, MiniDeps.later

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
    copilot_model = "gpt-5.1-codex",
  }
end)

later(function()
  add {
    source = "ravitemer/mcphub.nvim",
    depends = {
      "nvim-lua/plenary.nvim",
    },
    hooks = {
      post_checkout = function()
        vim
          .system({ "npm", "install", "-g", "mcp-hub@latest" }, { text = true })
          :wait()
      end,
    },
  }

  require("mcphub").setup {}

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
        model = "gpt-5.1-codex",
      },
      inline = {
        adapter = "copilot",
        model = "gpt-5.1-codex",
      },
      cmd = {
        adapter = "copilot",
        model = "gpt-5.1-codex",
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true, -- Show tool results directly in chat buffer
          format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          make_vars = true, -- Convert MCP resources to #variables for prompts
          make_slash_commands = true, -- Add MCP prompts as /slash commands
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
