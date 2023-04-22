local rofi_config = "$HOME/.config/awesome/extra/rofi/config.rasi"

local config = {
  apps = {
    searcher = "rofi -show combi -config " .. rofi_config,
    window_searcher = "rofi -show window -config " .. rofi_config,
    terminal = "alacritty",
    editor = "alacritty -e nvim",
    browser = "microsoft-edge-dev",
    explorer = "pcmanfm",
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

  layout = {
    top_panel = {
      height = 32,
    },
    right_panel = {
      width = 350,
      spacing = 10,
    },
  },

  theme = {
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
      size = 12,
    },
    icon_theme = "Papirus",
    random_wallpaper = {
      auto_timeout = 60, -- auto change wallpaper every 15 minutes
    },
  },
}

return config
