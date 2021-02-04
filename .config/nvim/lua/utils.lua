local M = {}

function M.add(value, str, sep)
  sep = sep or ","
  str = str or ""
  value = type(value) == "table" and table.concat(value, sep) or value
  return str ~= "" and table.concat({value, str}, sep) or value
end

function M.concat(value)
  return table.concat(value)
end

-- Apply global options
function M.apply_options(opts)
  for k, v in pairs(opts) do vim.opt[k] = v end
end

function M.apply_globals(globals)
  for k, v in pairs(globals) do vim.g[k] = v end
end

function M.apply_colorscheme(name, mode)
  M.apply_options({
    termguicolors = true,
    guicursor = 'n-v-c-sm:block,i-ci-ve:ver50-Cursor,r-cr-o:hor50',
    background = mode
  })
  
  M.apply_globals({
    colors_name = name
  })

  vim.api.nvim_command('colorscheme ' .. name)
end

-- Map keys
function M.map(mode, key, fn, opts)
  vim.api.nvim_set_keymap(mode, key, fn, opts or {})
end

-- Buffer local keymap
function M.buf_map(...)
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end

-- Buffer local option
function M.buf_option(...)
  vim.api.nvim_buf_set_option(bufnr, ...)
end

-- Check whether the current buffer is empty
function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

-- Check if the windows width is greater than a given number of columns
function M.has_width_gt(cols)
  return vim.fn.winwidth(0) / 2 > cols
end

return M
