local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end

	bufmap("<leader>r", vim.lsp.buf.rename)
	bufmap("<leader>a", vim.lsp.buf.code_action)

	bufmap("gd", vim.lsp.buf.definition)
	bufmap("gD", vim.lsp.buf.declaration)
	bufmap("gI", vim.lsp.buf.implementation)
	bufmap("<leader>D", vim.lsp.buf.type_definition)

	bufmap("gr", require("telescope.builtin").lsp_references)
	bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
	bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)
	bufmap("<leader>e", vim.diagnostic.open_float)

	bufmap("K", vim.lsp.buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("lspconfig").html.setup({ capabilities = capabilities })
require("lspconfig").cssls.setup({ capabilities = capabilities })
require("lspconfig").rust_analyzer.setup({ capabilities = capabilities })

require("neodev").setup()
require("lspconfig").lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
		},
	}
}

require("lspconfig").nil_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixfmt" },
			}
		},
	},
})

require("lspconfig").marksman.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").harper_ls.setup {
	settings = {
		["harper-ls"] = {
			diagnosticSeverity = "hint",
			spell_check = true,
			spelled_numbers = true,
			an_a = true,
			sentence_capitalization = true,
			unclosed_quotes = true,
			wrong_quotes = true,
			long_sentences = true,
			repeated_words = true,
			spaces = true,
			matcher = true,
			correct_number_suffix = true,
			number_suffix_capitalization = true,
			multiple_sequential_pronouns = true,
			linking_verbs = true,
			avoid_curses = true,
			terminating_conjunctions = true
		}
	},
}
