local M = {}

function M.prettyIcons()
	local icons = require("util.icons")
	local fn = vim.fn
	fn.sign_define(
		"DapBreakpoint",
		{ text = icons.kinds.Bug, texthl = "debugBreakpoint", linehl = "", numhl = "debugBreakpoint" }
	)
	fn.sign_define(
		"DapBreakpointCondition",
		{ text = icons.kinds.Bug, texthl = "DiagnosticWarn", linehl = "", numhl = "debugBreakpoint" }
	)
	fn.sign_define(
		"DapBreakpointRejected",
		{ text = icons.kinds.Bug, texthl = "DiagnosticError", linehl = "", numhl = "debugBreakpoint" }
	)
	fn.sign_define(
		"DapLogPoint",
		{ text = icons.kinds.String, texthl = "debugBreakpoint", linehl = "", numhl = "debugBreakpoint" }
	)
	fn.sign_define("DapStopped", {
		text = icons.kinds.BoldArrowRight,
		texthl = "debugBreakpoint",
		linehl = "debugPC",
		numhl = "DiagnosticSignError",
	})
end

function M.setup()
	M.keymap()
	M.prettyIcons()
	local dap = require("dap")
	local dapui = require("dapui")

	dapui.setup()
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

function M.keymap()
	local dap = require("dap")
	vim.keymap.set("n", "<F5>", function()
		dap.continue()
	end)
	vim.keymap.set("n", "<F6>", function()
		dap.step_over()
	end)
	vim.keymap.set("n", "<F7>", function()
		dap.step_into()
	end)
	vim.keymap.set("n", "<F8>", function()
		dap.step_out()
	end)
	vim.keymap.set("n", "<leader>b", function()
		dap.toggle_breakpoint()
	end)
	vim.keymap.set("n", "<leader>B", function()
		dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
	end)
	vim.keymap.set("n", "<leader>lp", function()
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end)
	vim.keymap.set("n", "<leader>dr", function()
		dap.repl.open()
	end)
end

return M
