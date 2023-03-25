local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- toggle options
map("n", "<leader>uf", require("plugins.spec.lsp.io.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>ud", require("util.core").toggle_diagnostics, { desc = "Toggle Diagnostics" })

-- windows
map("n", "=", function()
	local w = vim.api.nvim_win_get_width(0)
	vim.api.nvim_win_set_width(0, w + 5)
end, { desc = "Vertical +5" })
map("n", "-", function()
	local w = vim.api.nvim_win_get_width(0)
	vim.api.nvim_win_set_width(0, w - 5)
end, { desc = "Vertical -5" })
map("n", "<leader>=", function()
	local h = vim.api.nvim_win_get_height(0)
	vim.api.nvim_win_set_width(0, h + 5)
end, { desc = "Horizontal +2" })
map("n", "<leader>-", function()
	local h = vim.api.nvim_win_get_height(0)
	vim.api.nvim_win_set_width(0, h + 5)
end, { desc = "Horizontal -2" })

