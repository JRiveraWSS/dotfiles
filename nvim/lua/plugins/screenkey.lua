return {
  "NStefan002/screenkey.nvim",
  event = "VeryLazy", -- Load the plugin later to avoid startup delays
  config = function()
    require("screenkey").setup({
      -- Other configuration options can be added here
      win_opts = {
        relative = "editor",
        width = 40,
      },
    })
  end,
  keys = {
    -- Define a keymap to toggle screenkey on and off
    {
      "<leader>sK",
      function()
        require("screenkey").toggle()
      end,
      desc = "Toogle screenkey",
    },
  },
}
