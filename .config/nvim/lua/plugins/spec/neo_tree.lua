local M = {}

function M.setup()
	vim.g.neo_tree_remove_legacy_commands = 1

	require("neo-tree").setup({
        close_if_last_window = true,
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = true,
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
            },
		},
		window = {
			mappings = {
				["<space>"] = "none",
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true,
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
		},
	})

    vim.keymap.set("n", "<leader>fe", function ()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() });
    end)
end

return M
