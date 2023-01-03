local utils = require("zl.utils")

local commands = {
  "picom --config $HOME/.config/picom/picom.conf",
  "fcitx5 -d",
}

for _, command in pairs(commands) do
  utils.run_once(command)
end
