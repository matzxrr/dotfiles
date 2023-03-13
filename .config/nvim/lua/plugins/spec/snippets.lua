local M = {}

M.opts = {
	history = true,
	delete_check_events = "TextChanged",
}

function M.setup()
	require("luasnip.loaders.from_vscode").lazy_load()
	local luasnip = require("luasnip")
	luasnip.setup()
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
