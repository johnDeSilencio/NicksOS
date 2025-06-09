local dap = require("dap")

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set pretty print on" },
}

dap.configurations.rust = {
	{
		name = "Debug with codelldb",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input({
				prompt = "Path to executable: ",
				default = vim.fn.getcwd() .. "/target/debug/",
				completion = "file",
			})
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
}
