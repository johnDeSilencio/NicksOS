require("conform").setup({
	formatters_by_ft = {
		rust = { "leptosfmt", "--stdin", "--rustfmt", lsp_format = "fallback" },
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 750,
	},
	format_after_save = {
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
