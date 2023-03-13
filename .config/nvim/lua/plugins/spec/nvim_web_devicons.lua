local M = {}

function M.setup()
	require("nvim-web-devicons").setup({
		-- https://github.com/nvim-tree/nvim-web-devicons/blob/master/lua/nvim-web-devicons.lua
		override = {},
		color_icons = false,
	})
end

return M
