return {
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end
	},
	{
		"xero/miasma.nvim",
  		lazy = false,
  		priority = 1000,
  		config = function()
    		vim.cmd("colorscheme miasma")
  		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("lualine").setup({
				icons_enabled = true,
				theme = "miasma",
			})
		end,
	},
}
