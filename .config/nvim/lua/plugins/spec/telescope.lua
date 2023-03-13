local M = {}

function M.setup()
	require("telescope").setup({
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
		},
	})
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find Files" })
	vim.keymap.set("n", "<c-p>", builtin.git_files, { desc = "Git Files" })
	vim.keymap.set("n", "<leader>ps", function()
		builtin.grep_string({ search = vim.fn.input({ prompt = "Grep  " }) })
	end, { desc = "Grep Files" })
end

return M
