require("nvim-treesitter.configs").setup({
	sync_install = false,
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = { enable = true },
})

vim.treesitter.language.register("rust_with_rstml", { "rust" })
