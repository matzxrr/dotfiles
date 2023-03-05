vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open Explorer" })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Next Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "" })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })

vim.keymap.set("i", "<C-c>", "<Esc>")
