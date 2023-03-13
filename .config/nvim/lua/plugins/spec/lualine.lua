local M = {}

function M.setup()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			component_separators = "|",
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "NvimTree", "netrw" },
			globalstatus = true,
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				"diff", --[[require("lsp-status").status]]
			},

			lualine_x = {
				"filename",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },

			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {},
	})
end

return M
