local keymaps = require "@lucastrvsn/lsp/utils/keymaps"

---@class _.lsp.utils.options
local M = {
  _auto_format_augroup = vim.api.nvim_create_augroup("_.lsp.on_attach", {}),
}

---@class _.lsp.on_attach.options
---@field formatter table

---@param opts _.lsp.on_attach.options
---@return fun(client, bufnr)
function M.create_on_attach_handler(opts)
  return function(client, buffer)
    vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

    keymaps.setup {
      buffer = buffer,
    }

    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = buffer,
      callback = function()
        vim.diagnostic.open_float(nil, {
          focusable = false,
          close_events = {
            "BufLeave",
            "CursorMoved",
            "InsertEnter",
            "FocusLost",
          },
          max_width = 120,
          wrap = true,
          border = "rounded",
          source = "always",
          prefix = "- ",
          scope = "cursor",
        })
      end,
    })

    if client.supports_method "textDocument/formatting" then
      if opts.formatter.auto_format then
        vim.api.nvim_clear_autocmds {
          group = M._auto_format_augroup,
          buffer = buffer,
        }

        local format_autocmd_opts = {
          group = M._auto_format_augroup,
          buffer = buffer,
        }

        if opts.formatter.use == "null" then
          format_autocmd_opts.callback = function()
            vim.lsp.buf.format {
              filter = function(c)
                return c.name == "null-ls"
              end,
              timeout_ms = 2000,
              bufnr = buffer,
            }
          end
        elseif opts.formatter.use == "lsp" then
          format_autocmd_opts.callback = function()
            vim.lsp.buf.format {
              timeout_ms = 2000,
              bufnr = buffer,
            }
          end
        end

        vim.api.nvim_create_autocmd("BufWritePre", format_autocmd_opts)
      end
    end
  end
end

function M.get_capabilities()
  return require("cmp_nvim_lsp").default_capabilities()
end

return M
