local M = {}

M.options = {
	apps = {
		terminal = "alacritty",
		editor = "alacritty -e nvim",
		browser = "microsoft-edge-stable",
		explorer = "dolphin", -- "thunar"
	},
	keys = {
		modkey = "Mod4",
	},
}

local misc = function()
	require("awful.autofocus")
	-- require("awful.hotkeys_popup.keys")
end

function M.setup()
	require("zl.theme").setup()
	misc()
	require("zl.keys")
	require("zl.rules")
	require("zl.signals")
	require("zl.screen")
	require("zl.wibar")
end

return M
