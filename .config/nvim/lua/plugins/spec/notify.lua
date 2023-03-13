local M = {}

M.opts = { top_down = false, timeout = 3000 }

function M.setup()
	local notify = require("notify")
	notify.setup(M.opts)
	vim.notify = notify
end

return M
