return {
  -- Solarized Dark — matches Ghostty's "Builtin Solarized Dark" terminal theme
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    opts = {}, -- defaults: dark background (#002b36), follows vim.o.background
  },

  -- Tell LazyVim to load it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },
}
