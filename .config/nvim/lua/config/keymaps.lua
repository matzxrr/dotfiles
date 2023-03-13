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
