local M = {}

---@param client any
---@param buffer buffer
function M.on_attach(client, buffer)
	local format = require("plugins.spec.lsp.io.format").format

	local function map(lhs, rhs, opts)
		opts = opts or {}
		opts.silent = opts.silent ~= false
		opts.buffer = buffer
		if not opts.has or client.server_capabilities[opts.has .. "Provider"] then
			if opts.has then
				opts.has = nil
			end
			if opts.mode then
				opts.mode = nil
			end
			vim.keymap.set(opts.mode or "n", lhs, rhs, opts)
		end
	end

	map("<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
	map("<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
	map("gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Goto References", has = "definition" })
	map("gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
	map("gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
	map("gt", "<cmd>Telescope lsp_implementations<cr>", { desc = "Goto Implementation" })
	map("gt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Goto Type Definition" })
	map("K", vim.lsp.buf.hover, { desc = "Hover" })
	map("gK", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp" })
	map("<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp", mode = "i" })
	map("]d", M.diagnostic_goto(true), { desc = "Next Diagnostic" })
	map("[d", M.diagnostic_goto(false), { desc = "Prev Diagnostic" })
	map("]e", M.diagnostic_goto(true, vim.diagnostic.severity.ERROR), { desc = "Next Error" })
	map("[e", M.diagnostic_goto(false, vim.diagnostic.severity.ERROR), { desc = "Prev Error" })
	map("]w", M.diagnostic_goto(true, vim.diagnostic.severity.WARN), { desc = "Next Warning" })
	map("[w", M.diagnostic_goto(false, vim.diagnostic.severity.WARN), { desc = "Prev Warning" })
	map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", has = "codeAction" })
	map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", has = "codeAction", mode = "v" })
	map("<leader>cf", format, { desc = "Format Range", has = "documentRangeFormatting", mode = "v" })
	map("<leader>cf", format, { desc = "format", has = "documentFormatting" })
	map("<leader>cr", vim.lsp.buf.rename, { desc = "Rename", has = "rename" })
end

---@param next boolean
---@param severity? DiagnosticSeverity
---@return function
function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
