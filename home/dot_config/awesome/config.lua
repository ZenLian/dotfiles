local config = {
  apps = {
    launcher = "rofi -show drun -matching fuzzy",
    terminal = "alacritty",
    editor = "alacritty -e nvim",
    browser = "microsoft-edge-stable",
    explorer = "alacritty -e vifm",
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
    --font = "JetBrainsMono Nerd Font 10"
    font = {
      -- family = "Material Design Icons",
      -- family = "JetBrainsMono Nerd Font",
      -- family = "WenQuanYi Micro Hei Mono",
      -- family = "Caskaydia Cove Nerd Font Mono",
      family = "DejaVuSansMono Nerd Font",
      size = 12,
    },
    icon_font = {
      -- family = "Caskaydia Cove Nerd Font",
      -- family = "DejaVuSansMono Nerd Font",
      family = "Material Design Icons Desktop",
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

return config
