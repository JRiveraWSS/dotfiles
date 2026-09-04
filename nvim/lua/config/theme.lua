-- Colorscheme + transparency

local function set_transparent() -- set UI component to transparent
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

require("solarized").setup({
	transparent = { enabled = true },
})
vim.cmd.colorscheme("solarized")
set_transparent()

vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#2a2a2a", bg = "none" })

-- keep the tabline transparent to match the rest of the UI (preserve fg, drop bg)
for _, g in ipairs({
	"MiniTablineCurrent",
	"MiniTablineVisible",
	"MiniTablineHidden",
	"MiniTablineModifiedCurrent",
	"MiniTablineModifiedVisible",
	"MiniTablineModifiedHidden",
	"MiniTablineFill",
}) do
	local hl = vim.api.nvim_get_hl(0, { name = g, link = false })
	hl.bg = "none"
	vim.api.nvim_set_hl(0, g, hl)
end