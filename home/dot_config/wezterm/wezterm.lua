local wezterm = require("wezterm")
local configs = require("configs")
local utils = require("utils")

local config = {
  term = "wezterm",
  font_size = 14,
  font = wezterm.font("CaskaydiaCove Nerd Font Mono"),
  -- font = wezterm.font("FiraCode Nerd Font"),
  font_rules = {
    -- {
    --   intensity = "Bold",
    --   font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Bold" }),
    -- },
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
  window_decorations = "NONE",
  animation_fps = 30,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  switch_to_last_active_tab_when_closing_tab = true,

  -- scrollback
  scrollback_lines = 10000,
}

config = utils.table_extend(config, configs.keys, configs.colors)

-- wezterm.on("window-config-reloaded", function(window, pane)
--   window:toast_notification("wezterm", "configuration reloaded!", nil, 4000)
-- end)

return config
