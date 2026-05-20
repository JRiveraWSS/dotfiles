return {
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    init = function()
      -- Prevent netrw from loading so yazi handles directory navigation
      vim.g.loaded_netrwPlugin = 1
    end,
    keys = {
      -- {
      --   "<leader>-",
      --   mode = { "n", "v" },
      --   "<cmd>Yazi<cr>",
      --   desc = "Open yazi at the current file",
      -- },
      -- {
      --   "<leader>cw",
      --   "<cmd>Yazi cwd<cr>",
      --   desc = "Open yazi in nvim's working directory",
      -- },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
      {
        "<leader>e",
        "<cmd>Yazi<cr>",
        desc = "Open file manager (current file)",
      },
      {
        "<leader>E",
        "<cmd>Yazi cwd<cr>",
        desc = "Open file manager (cwd)",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      open_for_directories = true,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  {
    -- Disable neo-tree entirely; yazi is the sole file explorer
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    -- Disable snacks explorer sidebar (LazyVim auto-enables it when neo-tree is off)
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },
}
