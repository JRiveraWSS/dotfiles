# Replace nvim-tree with yazi as a floating file explorer

We replaced `nvim-tree.lua` with `mikavilpas/yazi.nvim`, bound to `<leader>e`. Unlike nvim-tree's persistent sidebar, yazi opens as a near-fullscreen floating window rooted at cwd (not a toggle, not "reveal current file") and closes back to the buffer on selection — this is yazi's native interaction model as a full file manager (previews, bulk rename, image preview) rather than a slim tree, so we leaned into the floating/picker shape instead of forcing a sidebar-like feel. `open_for_directories` is enabled, so `nvim <dir>` now opens yazi instead of netrw. The floating window's `NormalFloat`/`FloatBorder` highlights are overridden to `bg = none` to match the rest of the config's transparent-background aesthetic, replacing the old `NvimTree*` highlight overrides.

## Considered Options

- **Persistent sidebar** (closer to nvim-tree's behavior) — rejected; yazi isn't designed to run this way, and forcing it loses most of its file-manager UX.
- **Toggle with persisted instance / reveal current file** — rejected in favor of a simpler cwd-rooted open, to keep behavior predictable rather than stateful.
