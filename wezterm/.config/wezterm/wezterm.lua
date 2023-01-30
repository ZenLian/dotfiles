local wezterm = require("wezterm")
local act = wezterm.action

-- custom color scheme
local colors = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
colors.background = "#11111e"
colors.quick_select_label_bg = { Color = "#a6e3a1" }
colors.quick_select_label_fg = { Color = "#1e1e2e" }

local copy_mode = nil
if wezterm.gui then
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  table.insert(copy_mode, { key = "Backspace", mods = "NONE", action = act.CopyMode("MoveLeft") })
  table.insert(copy_mode, { key = "u", mods = "CTRL", action = act.CopyMode("PageUp") })
  table.insert(copy_mode, { key = "d", mods = "CTRL", action = act.CopyMode("PageDown") })
end

local config = {
  term = "wezterm",
  font_size = 14,
  font = wezterm.font("CaskaydiaCove Nerd Font"),
  font_rules = {
    {
      intensity = "Bold",
      font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Bold" }),
    },
    {
      italic = true,
      font = wezterm.font("VictorMono Nerd Font", { style = "Italic" }),
    },
    {
      italic = true,
      intensity = "Bold",
      font = wezterm.font("VictorMono Nerd Font", { weight = "Bold", style = "Italic" }),
    },
  },

  window_close_confirmation = "NeverPrompt",
  animation_fps = 30,
  window_decorations = "NONE",

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  -- scrollback
  scrollback_lines = 10000,

  -- tmux-like keymaps
  leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    {
      key = "a",
      mods = "LEADER|CTRL",
      action = wezterm.action.SendString("\x02"),
    },
    {
      key = "c",
      mods = "LEADER",
      action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = "x",
      mods = "LEADER",
      action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    {
      key = ";",
      mods = "LEADER",
      action = wezterm.action.ActivateLastTab,
    },
    {
      key = "|",
      mods = "LEADER|SHIFT",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
      key = "-",
      mods = "LEADER",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
      key = "h",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
      key = "l",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
      key = "k",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
      key = "j",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
      key = "v",
      mods = "LEADER",
      action = wezterm.action.ActivateCopyMode,
    },
    {
      key = "p",
      mods = "LEADER",
      action = wezterm.action.PasteFrom("Clipboard"),
    },

    -- fix weild <C-/> in neovim
    {
      key = "/",
      mods = "CTRL",
      action = wezterm.action.SendString("\x1f"),
    },
  },

  key_tables = {
    copy_mode = copy_mode,
  },

  color_schemes = {
    ["catppuccin"] = colors,
  },
  color_scheme = "catppuccin",
  -- color_scheme = "Catppuccin Mocha",
}

return config
