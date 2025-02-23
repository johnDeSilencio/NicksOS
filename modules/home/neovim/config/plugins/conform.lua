require("conform").setup({
	formatters_by_ft = {
		rust = { "leptosfmt" },
	},
	formatters = {
		leptosfmt = {
			command = "leptosfmt",
			append_args = { "--rustfmt" },
		},
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
