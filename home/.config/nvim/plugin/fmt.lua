-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and
-- FormatWriteLock commands
require("formatter").setup {
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		markdown = {
			function()
				return {
					exe = "dprint",
					args = {
						"--config",
						"~/.dprint.json",
						"fmt",
						"--stdin",
						vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = true,
				}
			end
		},

		-- Use the special "*" filetype for defining formatter
		-- configurations on any filetype
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		}
	}
}
