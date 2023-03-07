vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("i", "<C-c>", "<Esc>")
