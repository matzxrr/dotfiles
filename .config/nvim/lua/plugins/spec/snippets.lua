local M = {}

M.opts = {
	history = true,
	region_check_events = "InsertEnter",
	delete_check_events = "TextChanged,InsertLeave",
}

function M.setup()
	require("luasnip.loaders.from_vscode").lazy_load()
	local luasnip = require("luasnip")
	luasnip.setup(M.opts)
	vim.keymap.set("i", "<tab>", function()
		return luasnip.jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
	end, { expr = true, silent = true })
	vim.keymap.set("s", "<tab>", function()
		return luasnip.jump(1)
	end, {})
	vim.keymap.set("i", "<s-tab>", function()
		return luasnip.jump(-1)
	end, {})
	vim.keymap.set("s", "<s-tab>", function()
		return luasnip.jump(-1)
	end, {})
end

return M
