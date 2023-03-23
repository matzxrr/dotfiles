local M = {}

---Load config file
---@param mod string
function M.load(mod)
	local fullpath = "config." .. mod
	local status_ok, err = pcall(require, fullpath)
	if not status_ok then
		require("util.notify").error(err, { title = "config" })
	end
end

---Setup config
function M.setup()
	M.load("options")
	M.load("autocmds")
	M.load("keymaps")
end

return M
