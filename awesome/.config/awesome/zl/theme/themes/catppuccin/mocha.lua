local M = {}

local C = {
  rosewater = "#F5E0DC",
  flamingo = "#F2CDCD",
  pink = "#F5C2E7",
  mauve = "#CBA6F7",
  red = "#F38BA8",
  maroon = "#EBA0AC",
  peach = "#FAB387",
  yellow = "#F9E2AF",
  green = "#A6E3A1",
  teal = "#94E2D5",
  sky = "#89DCEB",
  sapphire = "#74C7EC",
  blue = "#89B4FA",
  lavender = "#B4BEFE",

  text = "#CDD6F4",
  subtext1 = "#BAC2DE",
  subtext0 = "#A6ADC8",
  overlay2 = "#9399B2",
  overlay1 = "#7F849C",
  overlay0 = "#6C7086",
  surface2 = "#585B70",
  surface1 = "#45475A",
  surface0 = "#313244",

  base = "#1E1E2E",
  mantle = "#181825",
  crust = "#11111B",
}

M.color = {
  primary = C.blue, -- primary80
  on_primary = C.base,
  -- primary_container =
  -- on_primary_container =

  -- secondary =
  -- on_secondary =
  -- secondary_container =
  -- on_secondary_container =

  -- tertiary =
  -- on_tertiary =
  -- tertiary_container =
  -- on_tertiary_container =

  error = C.flamingo,
  on_error = C.red,
  -- error_container =
  -- on_error_container =

  background = C.base,
  on_background = C.text,
  surface = C.surface0,
  on_surface = C.text,
  surface_variant = C.surface2,
  on_surface_variant = C.text,

  custom = C,
}

M.widgets = {
  cpu = {
    fg = C.lavender,
  },
  memory = {
    fg = C.yellow,
  },
  thermal = {
    fg = C.pink,
  },
  bluetooth = {
    fg = C.blue,
  },
  volume = {
    fg = C.green,
  },
  wifi = {
    fg = C.blue,
  },
  battery = {
    fg = C.teal,
  },
}

return M
