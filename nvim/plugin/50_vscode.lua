-- ┌──────────────────────────┐
-- │ VSCode Neovim integration │
-- └──────────────────────────┘
--
-- This file is loaded only when Neovim runs inside the VSCode Neovim extension
-- (asvetliakov.vscode-neovim). It maps the leader key groups to VSCode commands
-- so the same muscle memory works in both environments.
--
-- VSCode sets `vim.g.vscode = 1` at startup when the extension is active.

if not vim.g.vscode then return end

local vscode = require("vscode")

-- Helpers
local nmap = function(lhs, cmd, desc)
  vim.keymap.set("n", lhs, function() vscode.call(cmd) end, { desc = desc })
end
local vmap = function(lhs, cmd, desc)
  vim.keymap.set("v", lhs, function() vscode.call(cmd) end, { desc = desc })
end

-- Window navigation (replaces <C-w>h/j/k/l)
nmap("<C-h>", "workbench.action.navigateLeft",  "Focus left pane")
nmap("<C-j>", "workbench.action.navigateDown",  "Focus lower pane")
nmap("<C-k>", "workbench.action.navigateUp",    "Focus upper pane")
nmap("<C-l>", "workbench.action.navigateRight", "Focus right pane")

-- File finding (replaces mini.pick)
nmap("<Leader>ff", "workbench.action.quickOpen",              "Find files")
nmap("<Leader>fg", "workbench.action.findInFiles",            "Find in files (grep)")
nmap("<Leader>fb", "workbench.action.showAllEditors",         "Find buffers")
nmap("<Leader>fS", "workbench.action.gotoSymbol",             "Symbols document")
nmap("<Leader>fs", "workbench.action.showAllSymbols",         "Symbols workspace")
nmap("<Leader>fd", "workbench.actions.view.problems",         "Diagnostics workspace")
nmap("<Leader>fD", "workbench.actions.view.problems",         "Diagnostics buffer")

-- LSP actions (replaces <Leader>l* maps)
nmap("<Leader>la", "editor.action.quickFix",              "Code action")
nmap("<Leader>ld", "editor.action.showHover",             "Diagnostic popup")
nmap("<Leader>lf", "editor.action.formatDocument",        "Format document")
nmap("<Leader>lh", "editor.action.showHover",             "Hover")
nmap("<Leader>li", "editor.action.goToImplementation",    "Implementation")
nmap("<Leader>ll", "editor.runCodelens",                  "Code lens")
nmap("<Leader>lr", "editor.action.rename",                "Rename symbol")
nmap("<Leader>lR", "editor.action.goToReferences",        "References")
nmap("<Leader>ls", "editor.action.revealDefinition",      "Source definition")
nmap("<Leader>lt", "editor.action.goToTypeDefinition",    "Type definition")
vmap("<Leader>lf", "editor.action.formatSelection",       "Format selection")

-- Go-to motions (replaces built-in LSP motions)
nmap("gd", "editor.action.revealDefinition",   "Go to definition")
nmap("gr", "editor.action.goToReferences",     "Go to references")
nmap("K",  "editor.action.showHover",          "Hover documentation")

-- Diagnostics
nmap("]d", "editor.action.marker.next", "Next diagnostic")
nmap("[d", "editor.action.marker.prev", "Prev diagnostic")

-- Buffer / editor navigation (replaces mini.tabline + mini.bufremove)
nmap("<Leader>ba", "workbench.action.openPreviousRecentlyUsedEditorInGroup", "Alternate buffer")
nmap("<Leader>bd", "workbench.action.closeActiveEditor",                     "Close editor")
nmap("<Leader>bs", "workbench.action.files.newUntitledFile",                 "Scratch buffer")
nmap("]b", "workbench.action.nextEditor",     "Next editor")
nmap("[b", "workbench.action.previousEditor", "Prev editor")

-- File explorer (replaces mini.files)
nmap("<Leader>ed", "workbench.view.explorer",                          "Explorer (directory)")
nmap("<Leader>ef", "workbench.files.action.showActiveFileInExplorer",  "Explorer (reveal file)")

-- Git (replaces mini.git / mini.diff)
nmap("<Leader>ga", "workbench.view.scm",             "Added / stage changes")
nmap("<Leader>gc", "git.commit",                     "Commit")
nmap("<Leader>gd", "workbench.view.scm",             "Diff / source control")
nmap("<Leader>go", "git.openChange",                 "Open change (toggle overlay)")
nmap("<Leader>gs", "editor.action.dirtydiff.next",   "Next git change")

-- Terminal (replaces <Leader>t*)
nmap("<Leader>tt", "workbench.action.terminal.toggleTerminal", "Terminal toggle")
nmap("<Leader>tT", "workbench.action.terminal.new",            "Terminal new")

-- Other
nmap("<Leader>oz", "workbench.action.toggleMaximizeEditorGroup", "Zoom toggle")
