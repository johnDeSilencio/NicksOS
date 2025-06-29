local wk = require("which-key")

wk.add({
	{
		mode = { "n", "v" },
		{ "<leader>r", desc = "Rename symbol" },
		{ "<leader>a", desc = "Show code actions" },
		{ "gd", desc = "Go-to definition" },
		{ "gD", desc = "Go-to declaration" },
		{ "gI", desc = "Go-to implementation" },
		{ "gO", desc = "Open external docs" },
		{ "<leader>D", desc = "Go-to type definition" },
		{ "gr", desc = "Find references to symbol" },
		{ "K", desc = "Show details" },
		{ "<leader><tab>", group = "tabs" },
		{ "<leader>c", group = "code" },
		{ "<leader>d", group = "debug" },
		{ "<leader>dp", group = "profiler" },
		{ "<leader>f", group = "file/find" },
		{ "<leader>g", group = "git" },
		{ "<leader>gh", group = "hunks" },
		{ "<leader>q", group = "quit/session" },
		{ "<leader>s", group = "search" },
		{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
		{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
		{ "[", group = "prev" },
		{ "]", group = "next" },
		{ "g", group = "goto" },
		{ "gs", group = "surround" },
		{ "z", group = "fold" },
		{
			"<leader>b",
			group = "buffer",
			expand = function()
				return require("which-key.extras").expand.buf()
			end,
		},
		{
			"<leader>w",
			group = "windows",
			proxy = "<c-w>",
			expand = function()
				return require("which-key.extras").expand.win()
			end,
		},
		-- better descriptions
		{ "gx", desc = "Open with system app" },
	},
})
