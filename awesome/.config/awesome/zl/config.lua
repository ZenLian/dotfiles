local utils = require("zl.utils")

local M = {}

M.options = {
  apps = {
    launcher = "rofi -show drun",
    terminal = "alacritty",
    editor = "alacritty -e nvim",
    browser = "microsoft-edge-stable",
    -- explorer = "dolphin",
    explorer = "thunar",
  },
  keys = {
    modkey = "Mod4",
  },
  screens = {
    eDP = {
      dpi = 192,
    },
  },
  device = {
    wifi = "wlan0",
  },

  theme = {
    name = "catppuccin.mocha",

    flavour = "mocha",
    --font = "JetBrainsMono Nerd Font 10"
    font = {
      -- family = "Material Design Icons",
      -- family = "JetBrainsMono Nerd Font",
      -- family = "WenQuanYi Micro Hei Mono",
      family = "Caskaydia Cove Nerd Font",
      size = 12,
    },
    icon_font = {
      family = "Material Design Icons Desktop Regular",
      -- family = "JetBrainsMono Nerd Font",
      size = 12,
    },
    taglist = {
      square = false,
    },
    border_width = 1,
    border_radius = 10,
    gap = 5,
  },
}

M.setup = function(options)
  M.options = utils.table.extend(M.options, options or {})
end

return setmetatable(M, {
  __index = function(_, k)
    return M.options[k]
  end,
})
