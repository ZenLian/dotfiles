local M = {}

M.options = {
  apps = {
    launcher = "rofi -show drun",
    terminal = "alacritty",
    editor = "alacritty -e nvim",
    browser = "microsoft-edge-stable",
    explorer = "dolphin", -- "thunar"
    screenshoter = "",
  },
  keys = {
    modkey = "Mod4",
  },
  control = {
    vol = {
      cmd = "amixer -D pulse",
    },
  },
}

local misc = function()
  require("awful.autofocus")
  require("awful.util").shell = "bash"
  -- require("awful.hotkeys_popup.keys")

  -- Enable sloppy focus, so that focus follows mouse.
  client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
  end)
end

function M.setup()
  require("zl.theme").setup()
  misc()
  require("zl.configs.keys")
  require("zl.configs.rules")
  require("zl.configs.screen")
  require("zl.configs.wibar")
  require("zl.configs.titlebar")
  require("zl.configs.autostart")
end

return M
