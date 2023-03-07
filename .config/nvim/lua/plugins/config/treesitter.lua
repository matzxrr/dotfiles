local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

local languages = {
  "bash",
  "comment",
  "dockerfile",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "regex",
  "ruby",
  "scss",
  "toml",
  "yaml",
  "vim",
}

configs.setup {
  ensure_installed = languages,
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
