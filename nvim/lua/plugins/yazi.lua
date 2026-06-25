-- Force yazi to use the chafa image adapter inside Neovim's float.
-- Neovim's terminal (libvterm) can't pass Kitty/Sixel graphics through to
-- Ghostty, and ueberzug++ doesn't support GNOME Wayland, so chafa (Unicode
-- block-art) is the only in-pane previewer that actually renders. We briefly
-- hide the graphics-capable env vars so yazi's adapter detection falls through
-- to chafa, then restore them immediately — jobstart captures the env
-- synchronously before this function returns.
local function yazi_with_chafa(cmd)
  return function()
    local saved = {
      TERM = vim.env.TERM,
      TERM_PROGRAM = vim.env.TERM_PROGRAM,
      XDG_SESSION_TYPE = vim.env.XDG_SESSION_TYPE,
    }
    vim.env.TERM = "xterm-256color"
    vim.env.TERM_PROGRAM = nil
    vim.env.XDG_SESSION_TYPE = nil
    local ok, err = pcall(vim.cmd, cmd)
    vim.env.TERM = saved.TERM
    vim.env.TERM_PROGRAM = saved.TERM_PROGRAM
    vim.env.XDG_SESSION_TYPE = saved.XDG_SESSION_TYPE
    if not ok then
      error(err)
    end
  end
end

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
        yazi_with_chafa("Yazi toggle"),
        desc = "Resume the last yazi session",
      },
      {
        "<leader>e",
        yazi_with_chafa("Yazi"),
        desc = "Open file manager (current file)",
      },
      {
        "<leader>E",
        yazi_with_chafa("Yazi cwd"),
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
    -- Disable snacks explorer sidebar (LazyVim auto-enables it when neo-tree is off).
    -- Enable snacks.image so images opened from yazi render at full fidelity in
    -- a Neovim buffer via Ghostty's Kitty graphics protocol.
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
      image = { enabled = true },
    },
  },
}
