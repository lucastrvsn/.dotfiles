local wezterm = require "wezterm"

local C = wezterm.config_builder()

-- Window and renderer stuff
C.term = "wezterm"
C.front_end = "WebGpu"
C.use_resize_increments = true
C.freetype_load_target = "Light"
C.freetype_render_target = "Light"
C.window_close_confirmation = "NeverPrompt"
C.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Tab bar
C.tab_bar_at_bottom = true
C.hide_tab_bar_if_only_one_tab = false
C.tab_and_split_indices_are_zero_based = false
C.switch_to_last_active_tab_when_closing_tab = true
C.use_fancy_tab_bar = true
C.swallow_mouse_click_on_pane_focus = true

C.font = wezterm.font_with_fallback {
  {
    family = "MonoLisa",
    harfbuzz_features = { "+zero", "+ss03" },
  },
  "Symbols Nerd Font Mono",
}
C.font_size = 14
C.line_height = 1.12
C.cursor_blink_rate = 0
C.force_reverse_video_cursor = false
C.underline_thickness = "3px"
C.underline_position = "-4px"

C.color_scheme = "nightfox"

-- Keybindings
C.disable_default_key_bindings = true

C.leader = {
  key = "b",
  mods = "CTRL",
  timeout_milliseconds = 1000,
}

C.keys = {
  {
    key = "c",
    mods = "SUPER",
    action = wezterm.action.CopyTo "Clipboard",
  },
  {
    key = "v",
    mods = "SUPER",
    action = wezterm.action.PasteFrom "Clipboard",
  },
  {
    key = "k",
    mods = "SUPER",
    action = wezterm.action.ActivateCommandPalette,
  },
  {
    key = "-",
    mods = "SUPER",
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = "=",
    mods = "SUPER",
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = "a",
    mods = "CTRL",
    action = wezterm.action.PaneSelect,
  },
  {
    key = "b",
    mods = "LEADER",
    action = wezterm.action.SendKey {
      key = "b",
      mods = "CTRL",
    },
  },
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.SpawnTab "CurrentPaneDomain",
  },
  {
    key = "x",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentPane {
      confirm = true,
    },
  },
  {
    key = "-",
    mods = "LEADER",
    action = wezterm.action.SplitVertical {
      domain = "CurrentPaneDomain",
    },
  },
  {
    key = "|",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal {
      domain = "CurrentPaneDomain",
    },
  },
  {
    key = "z",
    mods = "LEADER",
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection "Left",
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection "Up",
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection "Right",
  },
  {
    key = "1",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(0),
  },
  {
    key = "2",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(1),
  },
  {
    key = "3",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(2),
  },
  {
    key = "4",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(3),
  },
  {
    key = "5",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(4),
  },
  {
    key = "6",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(5),
  },
  {
    key = "7",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(6),
  },
  {
    key = "8",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(7),
  },
  {
    key = "9",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(8),
  },
  {
    key = "0",
    mods = "LEADER",
    action = wezterm.action.ActivateTab(9),
  },
}

C.mouse_bindings = {
  {
    event = { Drag = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = wezterm.action.StartWindowDrag,
  },
}

return C
