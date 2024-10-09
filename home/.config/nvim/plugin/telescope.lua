require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		}
	}
})

require("telescope").load_extension("fzf")

-- Initialize keybindings for telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Replace default netrw with telescope.find_files
local find_files_hijack_netrw = vim.api.nvim_create_augroup("find_files_hijack_netrw", { clear = true })
-- clear FileExplorer appropriately to prevent netrw from launching on folders
-- netrw may or may not be loaded before telescope-find-files
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	once = true,
	callback = function()
		pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = find_files_hijack_netrw,
	pattern = "*",
	callback = function()
		vim.schedule(function()
			-- Early return if netrw or not a directory
			if vim.bo[0].filetype == "netrw" or vim.fn.isdirectory(vim.fn.expand("%:p")) == 0 then
				return
			end

			vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")

			require("telescope.builtin").find_files({
				cwd = vim.fn.expand("%:p:h"),
			})
		end)
	end,
})
