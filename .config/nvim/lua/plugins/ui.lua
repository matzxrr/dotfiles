return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = "tokyonight",
				component_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},
			},
		},
		dependencies = { "kyazdani42/nvim-web-devicons", lazy = true }
	},
}
