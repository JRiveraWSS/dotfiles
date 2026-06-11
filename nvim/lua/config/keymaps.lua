-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Colemak JEHN (Mod-DH) layout toggle
-- Persists across sessions; toggle with <leader>uk or :ToggleLayout
local layout_file = vim.fn.stdpath("data") .. "/keyboard_layout"

-- Each entry: { from, to, modes }
-- "from" = physical Colemak key pressed, "to" = QWERTY vim action to execute (noremap)
local colemak_maps = {
  -- Navigation cluster: k=left, n=down, l=up, e=right
  { "k", "h", { "n", "x", "o" } }, -- left  (k freed from "up",   h freed to next-find)
  { "n", "j", { "n", "x", "o" } }, -- down  (n freed from search, j freed to end-word)
  { "l", "k", { "n", "x", "o" } }, -- up    (l freed from right,  k freed to left)
  { "e", "l", { "n", "x", "o" } }, -- right (e freed from end-word)

  -- Word motions: j/J take e/E's old jobs (end word/WORD)
  { "j", "e", { "n", "x", "o" } }, -- end word
  { "J", "E", { "n", "x", "o" } }, -- end WORD

  -- Join lines: E takes J's old job (J now = end WORD)
  { "E", "J", { "n", "x" } }, -- join lines

  -- Search: h/H take n/N's old jobs (n/N freed to navigation/screen)
  { "h", "n", { "n", "x" } }, -- next search match
  { "H", "N", { "n", "x" } }, -- prev search match

  -- Screen positions: freed from H/L (H→prev-search, L→up-navigation)
  { "L", "H", { "n" } }, -- screen top    (L freed from screen-bottom)
  { "N", "L", { "n" } }, -- screen bottom (N freed from search since h/H handle it)
}

local function apply_colemak()
  for _, map in ipairs(colemak_maps) do
    local from, to, modes = map[1], map[2], map[3]
    for _, mode in ipairs(modes) do
      vim.keymap.set(mode, from, to, { noremap = true, silent = true })
    end
  end
end

local function apply_qwerty()
  for _, map in ipairs(colemak_maps) do
    local from, modes = map[1], map[3]
    for _, mode in ipairs(modes) do
      pcall(vim.keymap.del, mode, from)
    end
  end
end

local function save_layout(name)
  local f = io.open(layout_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

local function load_layout()
  local f = io.open(layout_file, "r")
  if not f then return "qwerty" end
  local content = f:read("*l")
  f:close()
  return content or "qwerty"
end

local function toggle_layout()
  if vim.g.colemak_mode then
    apply_qwerty()
    vim.g.colemak_mode = false
    save_layout("qwerty")
    vim.notify("QWERTY mode", vim.log.levels.INFO, { title = "Keyboard Layout" })
  else
    apply_colemak()
    vim.g.colemak_mode = true
    save_layout("colemak")
    vim.notify("Colemak JEHN mode", vim.log.levels.INFO, { title = "Keyboard Layout" })
  end
end

-- Apply persisted layout on startup
if load_layout() == "colemak" then
  apply_colemak()
  vim.g.colemak_mode = true
else
  vim.g.colemak_mode = false
end

vim.api.nvim_create_user_command("ToggleLayout", toggle_layout, { desc = "Toggle QWERTY / Colemak JEHN layout" })
vim.keymap.set("n", "<leader>uk", toggle_layout, { desc = "Toggle keyboard layout (Colemak/QWERTY)", noremap = true, silent = true })
