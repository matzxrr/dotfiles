local M = {}

function M.setup()
	local nls = require("null-ls")
	local opts = {
		root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
		sources = {
			-- Make sure mason installs the formatters
			nls.builtins.formatting.stylua,
			nls.builtins.formatting.shfmt,
			nls.builtins.code_actions.eslint_d,
			nls.builtins.diagnostics.eslint_d,
			nls.builtins.formatting.eslint_d,
		},
	}
	nls.setup(opts)
end

return M
