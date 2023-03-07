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

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then return end

local plugins = {
    -----------------------------------------------------------------------------
    -- Look & feel
    -----------------------------------------------------------------------------
    {
        "kyazdani42/nvim-web-devicons",
        config = function() require("plugins.config.nvim_web_devicons") end,
    },
    {
        "folke/tokyonight.nvim",
        config = function() require("plugins.config.theme") end,
        lazy = false,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function() require("plugins.config.colorizer") end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function() require("plugins.config.lualine") end,
        event = "VimEnter",
    },
    -----------------------------------------------------------------------------
    -- LSP
    -----------------------------------------------------------------------------
    { "nvim-lua/lsp-status.nvim" },  -- Used by other plugins for basic lsp info
    {
        "j-hui/fidget.nvim",
        config = function() require("plugins.config.fidget") end,
        event = "BufReadPre",
    },
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function() require("plugins.config.trouble") end,
        event = "BufEnter",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function() require("plugins.config.lsp") end,
    },
    -----------------------------------------------------------------------------
    -- Completions
    -----------------------------------------------------------------------------
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer", -- Buffer completions
            "hrsh7th/cmp-path", -- Path completions
            "hrsh7th/cmp-cmdline", -- Cmdline completions
            "hrsh7th/cmp-nvim-lsp", -- LSP completions
            "hrsh7th/cmp-nvim-lsp-document-symbol", -- For textDocument/documentSymbol

            -- Snippets
            "saadparwaiz1/cmp_luasnip", -- snippet completions
            "L3MON4D3/LuaSnip", --snippet engine
            "rafamadriz/friendly-snippets", -- a bunch of snippets to

            -- Misc
            "lukas-reineke/cmp-under-comparator", -- Tweak completion order
            "f3fora/cmp-spell",
        },
        config = function() require("plugins.config.cmp") end,
    },
    -----------------------------------------------------------------------------
    -- Treesitter
    -----------------------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function() require("plugins.config.treesitter") end,
        event = "BufReadPre",
    },
    -----------------------------------------------------------------------------
    -- Telescope
    -----------------------------------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("plugins.config.telescope") end,
        event = "BufEnter",
    },
    -----------------------------------------------------------------------------
    -- Misc
    -----------------------------------------------------------------------------
    {
        "numToStr/Comment.nvim",
        config = function() require("plugins.config.comment") end,
        event = "BufEnter",
    },
    {
        "folke/which-key.nvim",
        config = function () require("plugins.config.whichkey") end,
        event = "VeryLazy",
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function () require("plugins.config.harpoon") end,
        event = "VeryLazy",
    },
    {
        "windwp/nvim-autopairs",
        config = function() require("plugins.config.autopairs") end,
        event = "VeryLazy",
    },
}

local opts = {
    defaults = {
        lazy = true, -- should plugins be lazy-loaded?
    },
    lockfile = vim.fn.stdpath("config") .. "/.lazy-lock.json",
    concurrency = 50,
    install = {
        missing = true, -- install missing plugins on startup.
    },
    ui = {
        size = {
            width = 0.7,
            height = 0.7,
        },
    },
    performance = {
        rtp = {
            disabled_plugins = require "plugins.disable_builtins",
        },
    },
}

lazy.setup(plugins, opts)

