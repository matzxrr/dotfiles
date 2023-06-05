local M = {}

local languages = {
	"bash",
	"c",
    "rust",
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
        indent = { enable = true },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	})
end

return M
