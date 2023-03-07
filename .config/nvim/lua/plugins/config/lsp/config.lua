local status_ok, mason = pcall(require, "mason")
if not status_ok then return end

mason.setup()

require("mason-lspconfig").setup {
    ensure_installed = {
        -- extend configs
        "lua_ls",
        "jsonls",

        -- default configs
        "bashls",
        "cssls",
        "dockerls",
        "tsserver",
        "yamlls",
    },
}

local defaults = {
    on_attach = require("plugins.config.lsp.handlers").on_attach,
    capabilities = require("plugins.config.lsp.handlers").capabilities,
}

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
local luadev_ok, luadev = pcall(require, "neodev")
if luadev_ok then
    luadev.setup()
end

-- Setup LSP configs, if there is an override, use it
local lspconfig = require("lspconfig")
local get_servers = require("mason-lspconfig").get_installed_servers

for _, server_name in ipairs(get_servers()) do
    local settings_exists, settings = pcall(require, "plugins.config.lsp.settings." .. server_name)
    if settings_exists then
        lspconfig[server_name].setup(vim.tbl_deep_extend("force", defaults, settings))
    else
        lspconfig[server_name].setup(defaults)
    end
end

