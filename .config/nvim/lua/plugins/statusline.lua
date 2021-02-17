local gl = require("galaxyline")

local cmd = vim.cmd
local fn = vim.fn
local api = vim.api
local section = gl.section

gl.short_line_list = { 'dirvish' }

local palletes = {
  ['gruvbox-material'] = {
    background = "#3a3735",
    foreground = "#ddc7a1",
    red = '#ea6962',
    green = '#a9b665',
    yellow = '#d8a657',
    orange = '#e78a4e',
    blue = '#7daea3',
    magenta = '#d3869b',
    cyan = '#0e363e'
  },
  spaceduck = {
    background = "#0f111b",
    foreground = "#ecf0c1",
    red = '#e33400',
    green = '#5ccc96',
    yellow = '#f2ce00',
    orange = '#e39400',
    blue = '#7a5ccc',
    magenta = '#ce6f8f',
    cyan = '#00a3cc'
  },
  miramare = {
    background = "#242021",
    foreground = "#e6d6ac",
    red = '#e68183',
    green = '#87af87',
    yellow = '#d9bb80',
    orange = '#e39b7b',
    blue = '#89beba',
    magenta = '#d3a0bc',
    cyan = '#87c095'
  }
}

local colors
if palletes[vim.g.colors_name] ~= nil then
  colors = palletes[vim.g.colors_name]
else
  colors = palletes['gruvbox-material']
end

local buffer_not_empty = function()
  if fn.empty(fn.expand("%:t")) ~= 1 then
    return true
  end

  return false
end

local check_width = function()
  local squeeze_width = fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end

  return false
end

local get_mode_color = function(mode)
  local mode_colors = {
    n = { fg = colors.background, bg = colors.foreground },
    i = { fg = colors.background, bg = colors.blue },
    c = { fg = colors.background, bg = colors.red },
    V = { fg = colors.background, bg = colors.magenta },
    [""] = { fg = colors.background, bg = colors.magenta },
    v = { fg = colors.background, bg = colors.magenta },
    R = { fg = colors.background, bg = colors.green }
  }

  if mode_colors[mode] ~= nil then
    return mode_colors[mode]
  end

  return colors.purple
end

local get_mode_label = function(mode)
  local mode_labels = {
    n = 'NORMAL',
    i = 'INSERT',
    c = 'COMMAND',
    v = 'VISUAL',
    [""] = 'V-BLOCK',
    V = 'V-LINE',
    R = 'REPLACE'
  }

  if mode_labels[mode] ~= nil then return mode_labels[mode] else return mode end
end

section.left[1] = {
  ViMode = {
    provider = function()
      local current_mode = fn.mode()
      local label = get_mode_label(current_mode)
      local color = get_mode_color(current_mode)
      api.nvim_command('hi GalaxyViMode guifg=' .. color.fg .. ' guibg=' .. color.bg)
      return '  ' .. label
    end,
    highlight = { colors.foreground, colors.background },
  }
}

section.left[2] = {
  ViModeSeparator = {
    provider = function()
      local current_mode = fn.mode()
      local color = get_mode_color(current_mode)
      api.nvim_command('hi GalaxyViModeSeparator guifg=' .. color.bg)
      return ''
    end,
    separator = ' ',
    highlight = { colors.foreground, colors.background },
    separator_highlight = { colors.foreground, colors.background }
  }
}

section.left[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color,
      colors.background
    }
  }
}

section.left[4] = {
  FileName = {
    provider = "FileName",
    condition = buffer_not_empty,
    highlight = { colors.foreground, colors.background }
  }
}

section.right[1] = {
  GitIcon = {
    provider = function()
      return ' '
    end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = { colors.yellow, colors.background },
  }
}

section.right[2] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = { colors.magenta, colors.background, 'bold' }
  }
}

section.right[3] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = check_width,
    icon = ' ',
    highlight = { colors.green, colors.background }
  }
}
section.right[4] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = check_width,
    icon = '柳',
    highlight = { colors.yellow, colors.background }
  }
}
section.right[5] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = check_width,
    icon = ' ',
    highlight = { colors.red, colors.background }
  }
}

section.right[6] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = { colors.red, colors.background },
  }
}
section.right[7] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = { colors.yellow, colors.background },
  }
}

section.right[8] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = { colors.green, colors.background },
  }
}

section.right[9] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = { colors.blue, colors.background },
  }
}

section.short_line_left[1] = {
  Space = {
    provider = function() return ' ' end,
    highlight = { colors.foreground, colors.background }
  }
}

section.short_line_left[2] = {
  BufferName = {
    provider = function()
      local file_name = require('galaxyline.provider_fileinfo').get_current_file_name()
      local file_icon = require('galaxyline.provider_fileinfo').get_file_icon()
      local buffer_type = require('galaxyline.provider_buffer').get_buffer_filetype()

      if fn.empty(file_name) ~= 0 then
        return string.lower(buffer_type)
      end

      return file_icon .. file_name
    end,
    highlight = { colors.foreground, colors.background }
  }
}

section.short_line_left[3] = {
  BufferNameSeparator = {
    provider = function() return '' end,
    highlight = { colors.background, colors.background }
  }
}

gl.load_galaxyline()
