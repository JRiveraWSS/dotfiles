-- Solarized Dark
-- Based on Ethan Schoonover's Solarized: https://ethanschoonover.com/solarized/
--
-- Palette mapping:
--   bg_edge2 → custom (deeper than base03)
--   bg_edge  → base03 (#002b36)
--   bg       → base02 (#073642)
--   bg_mid   → interpolated base02/base01
--   bg_mid2  → base01 (#586e75)
--   fg_mid2  → base00 (#657b83)
--   fg_mid   → base0  (#839496)
--   fg       → base1  (#93a1a1)
--   fg_edge  → base2  (#eee8d5)
--   fg_edge2 → base3  (#fdf6e3)

vim.o.background = 'dark'

-- stylua: ignore
local palette = {
  bg_edge2 = '#001e28', bg_edge = '#002b36', bg = '#073642', bg_mid = '#3d5059', bg_mid2 = '#586e75',
  fg_edge2 = '#fdf6e3', fg_edge = '#eee8d5', fg = '#93a1a1', fg_mid = '#839496', fg_mid2 = '#657b83',

  accent = '#268bd2', accent_bg = '#003050',

  red    = '#dc322f',    red_bg = '#3d0a0a',
  orange = '#cb4b16', orange_bg = '#3d1500',
  yellow = '#b58900', yellow_bg = '#302400',
  green  = '#859900',  green_bg = '#1e2400',
  cyan   = '#2aa198',   cyan_bg = '#002d2a',
  azure  = '#268bd2',  azure_bg = '#003050',
  blue   = '#6c71c4',   blue_bg = '#1c1d3d',
  purple = '#d33682', purple_bg = '#3a0c22',
}

require('mini.hues').apply_palette(palette)
vim.g.colors_name = 'solarizeddark'
