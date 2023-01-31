local wezterm = require("wezterm")

local CA = "CTRL|ALT"

local keys = {

  -- spawn/close tab
  { key = "t", mods = CA, action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "q", mods = CA, action = wezterm.action.CloseCurrentTab { confirm = false } },
  -- navigate tab
  { key = "[", mods = CA, action = wezterm.action.ActivateTabRelative(-1) },
  { key = "]", mods = CA, action = wezterm.action.ActivateTabRelative(1) },
  { key = ";", mods = CA, action = wezterm.action.ActivateLastTab },
  -- move tab
  { key = ",", mods = CA, action = wezterm.action.MoveTabRelative(-1) },
  { key = ".", mods = CA, action = wezterm.action.MoveTabRelative(1) },

  -- split pane
  { key = "-", mods = CA, action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "=", mods = CA, action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  -- navigate pane
  { key = "h", mods = CA, action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = CA, action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = CA, action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = CA, action = wezterm.action.ActivatePaneDirection("Right") },
  -- adjust pane size
  { key = "h", mods = "SHIFT|ALT|CTRL", action = wezterm.action.AdjustPaneSize { "Left", 5 } },
  { key = "l", mods = "SHIFT|ALT|CTRL", action = wezterm.action.AdjustPaneSize { "Right", 5 } },
  { key = "k", mods = "SHIFT|ALT|CTRL", action = wezterm.action.AdjustPaneSize { "Up", 5 } },
  { key = "j", mods = "SHIFT|ALT|CTRL", action = wezterm.action.AdjustPaneSize { "Down", 5 } },

  -- copy mode(CS-X)
  -- { key = "v", mods = CA, action = wezterm.action.ActivateCopyMode },

  -- laucher
  { key = "p", mods = CA, action = wezterm.action.ShowLauncher },
  { key = "w", mods = CA, action = wezterm.action.ShowLauncherArgs { flags = "WORKSPACES" } },

  -- FIX: weild <C-/> in neovim
  { key = "/", mods = "CTRL", action = wezterm.action.SendString("\x1f") },
}

-- num keys
for i = 1, 9 do
  table.insert(keys, {
    key = tostring(i),
    mods = "CTRL",
    action = wezterm.action.ActivateTab(i - 1),
  })
  table.insert(keys, {
    key = tostring(i),
    mods = "ALT",
    action = wezterm.action.ActivateTab(i - 1),
  })
  table.insert(keys, {
    key = tostring(i),
    mods = "CTRL|ALT",
    action = wezterm.action.MoveTab(i - 1),
  })
end

local copy_mode
if wezterm.gui then
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  table.insert(copy_mode, { key = "u", mods = "CTRL", action = wezterm.action.CopyMode("PageUp") })
  table.insert(copy_mode, { key = "d", mods = "CTRL", action = wezterm.action.CopyMode("PageDown") })
end

return {
  keys = keys,
  key_tables = {
    copy_mode = copy_mode,
  },
  mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}
