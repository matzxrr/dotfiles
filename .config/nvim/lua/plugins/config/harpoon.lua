local mark_ok, mark = pcall(require, "harpoon.mark")
if not mark_ok then return end

local ui_ok, ui = pcall(require, "harpoon.ui")
if not ui_ok then return end

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

