local M = {}

function M.setup()
	local mark = require("harpoon.mark")
	local ui = require("harpoon.ui")

	vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon Mark File" })
	vim.keymap.set("n", "<c-e>", ui.toggle_quick_menu, { desc = "Harpoon Menu" })
end

return M
