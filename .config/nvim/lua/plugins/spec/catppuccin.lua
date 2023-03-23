local M = {}

function M.setup()
    require("catppuccin").setup({
        flavor = "mocha",
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
        },
    })
    vim.cmd.colorscheme("catppuccin")
end

return M
