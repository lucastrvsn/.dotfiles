local lspconfig = require "lspconfig"
local helpers = require "@lucastrvsn/lsp/utils/helpers"

---@class _.lsp.utils
local M = {}

local function create_config(language)
  local config = {
    server = {},
    formatter = {},
  }

  if type(language.server) == "table" then
    config.server = {
      name = language.server[1],
      config = language.server[2] or {},
    }
  elseif type(language.server) == "string" then
    config.server = {
      name = language.server,
      config = {},
    }
  end

  if type(language.formatter) == "table" then
    config.formatter = {
      use = language.formatter.use or "lsp",
      auto_format = language.formatter.auto_format or true,
    }
  end

  return config
end

---@class _.lsp.utils.lsp.config
---@field filetypes? string[]
---@field settings? table
---@field capabilities? function
---@field on_new_config? function
---@field on_attach? function

---@class _.lsp.utils.lsp.languages
---@field name string
---@field enabled? boolean
---@field config? _.lsp.utils.lsp.config

---@class _.lsp.utils.setup.options
---@field languages _.lsp.utils.lsp.languages

---@param opts _.lsp.utils.setup.options
function M.setup(opts)
  vim.validate {
    opts = { opts, "table", false },
    ["opts.languages"] = { opts.languages, "table", false },
  }

  vim.diagnostic.config {
    float = {
      scope = "cursor",
    },
    underline = false,
    update_in_insert = false,
  }

  for _, language in pairs(opts.languages) do
    vim.validate {
      language = { language, "table", false },
    }

    local config = create_config(language)
    local lsp = lspconfig[config.server.name]

    if lsp ~= nil then
      lsp.setup {
        cmd = config.server.config.cmd or nil,
        filetypes = config.server.config.filetypes or nil,
        settings = config.server.config.settings or nil,
        on_new_config = config.server.config.on_new_config or nil,
        on_attach = helpers.create_on_attach_handler {
          formatter = config.formatter,
        },
        capabilities = helpers.get_capabilities(),
      }
    end
  end
end

return M
