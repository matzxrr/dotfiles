local M = {}

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

local enabled = true

function M.toggle_diagnostics()
	enabled = not enabled
	if enabled then
		vim.diagnostic.enable()
		require("util.notify").info("Enabled diagnostics", { title = "Diagnostics" })
	else
		vim.diagnostic.disable()
		require("util.notify").warn("Disabled diagnostics", { title = "Diagnostics" })
	end
end

return M
