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
}

M.setup = function(options)
  M.options = utils.table.extend(M.options, options or {})
end

return setmetatable(M, {
  __index = function(_, k)
    return M.options[k]
  end,
})
