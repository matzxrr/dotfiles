local M = {}

---Install lazy if it doesn't exist and add it to rtp
function M.installLazy()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

M.lazyPlugins = {
	--------------------------------------------------------
	-- LSP
	--------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			"folke/neodev.nvim",
            "jose-elias-alvarez/typescript.nvim",
            "simrat39/rust-tools.nvim",
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("plugins.spec.lsp.lspconfig").setup()
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		config = function()
			require("plugins.spec.lsp.null_ls").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("plugins.spec.lsp.mason").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("plugins.spec.lsp.fidget").setup()
		end,
		event = "BufEnter",
	},
	-------------------------------------------------------
	-- CMP
	-------------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("plugins.spec.cmp").setup()
		end,
	},
	{

		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		event = "InsertEnter",
		config = function()
			require("plugins.spec.snippets").setup()
		end,
	},
	-------------------------------------------------------
	-- TREESITTER
	-------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("plugins.spec.treesitter").setup()
		end,
		event = "BufEnter",
	},
	-------------------------------------------------------
	-- TELESCOPE
	-------------------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.spec.telescope").setup()
		end,
		event = "VimEnter",
	},
	-------------------------------------------------------
	-- EDITOR
	-------------------------------------------------------
	{
		"folke/tokyonight.nvim",
		lazy = false,
		config = function()
			require("plugins.spec.tokyonight").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function()
			require("plugins.spec.mini_pairs").setup()
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			require("plugins.spec.notify").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.spec.lualine").setup()
		end,
		event = "VimEnter",
	},
	{
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.spec.nvim_web_devicons").setup()
		end,
	},
	{
		"theprimeagen/harpoon",
		config = function()
			require("plugins.spec.harpoon").setup()
		end,
		event = "VimEnter",
	},
	-------------------------------------------------------
	-- SHARED
	-------------------------------------------------------
	{ "nvim-lua/plenary.nvim" },
}

M.lazyConfig = {
	defaults = {
		lazy = true,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"matchit",
				"matchparen",
				"tar",
				"tarPlugin",
				"tutor",
				"rrhelper",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
			},
		},
	},
}

---Setup plugins
function M.setup()
	M.installLazy()
	require("lazy").setup(M.lazyPlugins, M.lazyConfig)
	vim.api.nvim_exec_autocmds("User", { pattern = "mattdevio_config" })
end

return M
