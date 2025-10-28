return {
  "fmbarina/multicolumn.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    base_set = {
      scope = "window",
      rulers = { 80 },
      to_line_end = true,
      bg_color = "#f08800",
      fg_color = "#17172e",
    },
  },
}
