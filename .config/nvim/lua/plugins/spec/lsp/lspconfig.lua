local M = {}

M.opts = {
	diagnostics = {
		underline = true,
		update_in_insert = false,
		virtual_text = { spacing = 4, prefix = "●" },
		severity_sort = true,
	},
	servers = {
		jsonls = {},
		tsserver = {},
		rust_analyzer = {},
		lua_ls = {
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		},
	},
	setup = {
		tsserver = function(_, opts)
			require("util.core").on_attach(function(client, buffer)
				if client.name == "tsserver" then
					vim.keymap.set(
						"n",
						"<leader>co",
						"<cmd>TypescriptOrganizeImports<CR>",
						{ buffer = buffer, desc = "Organize Imports" }
					)
					vim.keymap.set(
						"n",
						"<leader>cR",
						"<cmd>TypescriptRenameFile<CR>",
						{ desc = "Rename File", buffer = buffer }
					)
				end
			end)
			require("typescript").setup({ server = opts })
			return true
		end,
		rust_analyzer = function()
			local base = vim.env.MASON .. "/packages/codelldb/extension/"
			local rt = require("rust-tools")
			rt.setup({
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(
						base .. "adapter/codelldb",
						base .. "lldb/lib/liblldb.so"
					),
				},
			})
			require("util.core").on_attach(function(client, buffer)
				if client.name == "rust_analyzer" then
					vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = buffer })
					vim.keymap.set("n", "<leader>ca", rt.code_action_group.code_action_group, { buffer = buffer })
				end
			end)
			return true
		end,
	},
}

M.neo_dev_opts = { experimental = { pathStrict = true } }

function M.setup()
	-- setup pre-req
	require("neodev").setup(M.neo_dev_opts)

	-- setup formatting and keymaps
	require("util.core").on_attach(function(client, buffer)
		require("plugins.spec.lsp.io.format").on_attach(client, buffer)
		require("plugins.spec.lsp.io.keymaps").on_attach(client, buffer)
	end)

	-- diagnostics
	for name, icon in pairs(require("util.icons").diagnostics) do
		name = "DiagnosticSign" .. name
		vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
	end
	vim.diagnostic.config(M.opts.diagnostics)

	-- get list of servers and default capabilities
	local servers = M.opts.servers
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	-- setup server lsp
	local function setup(server)
		local server_opts = vim.tbl_deep_extend("force", {
			capabilities = vim.deepcopy(capabilities),
		}, servers[server] or {})

		if M.opts.setup[server] then
			if M.opts.setup[server](server, server_opts) then
				return
			end
		end
		require("lspconfig")[server].setup(server_opts)
	end

	local mlsp = require("mason-lspconfig")
	local available = mlsp.get_available_servers()

	local ensure_installed = {}
	for server, server_opts in pairs(servers) do
		if server_opts then
			if server_opts.mason == false or not vim.tbl_contains(available, server) then
				setup(server)
			else
				ensure_installed[#ensure_installed + 1] = server
			end
		end
	end

	mlsp.setup({ ensure_installed = ensure_installed })
	mlsp.setup_handlers({ setup })
end

return M
