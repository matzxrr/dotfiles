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
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = "|",
			show_trailing_blankline_indent = false,
		},
		enabled = false,
	},
}
