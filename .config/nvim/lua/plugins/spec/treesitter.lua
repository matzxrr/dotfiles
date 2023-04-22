local M = {}

local languages = {
	"bash",
	"c",
	"help",
	"html",
	"javascript",
	"json",
	"lua",
	"luap",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"tsx",
	"typescript",
	"vim",
	"yaml",
	"typescript",
	"tsx",
}

function M.setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = languages,
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	})
end

return M
