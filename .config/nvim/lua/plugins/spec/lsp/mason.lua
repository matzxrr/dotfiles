local M = {}

M.opts = {
	ensure_installed = {
		"stylua",
		"shfmt",
        "eslint_d",
	},
}

function M.setup()
	require("mason").setup(M.opts)
	local mr = require("mason-registry")
	for _, tool in ipairs(M.opts.ensure_installed) do
		local p = mr.get_package(tool)
		if not p:is_installed() then
			p:install()
		end
	end
end

return M
