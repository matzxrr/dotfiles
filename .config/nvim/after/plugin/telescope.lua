local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find Files" })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git Files" })
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input({ prompt = "Grep > " }) });
end, { desc = "Grep Search All Files" })

