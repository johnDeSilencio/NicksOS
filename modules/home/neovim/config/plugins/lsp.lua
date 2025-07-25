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

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

require("lspconfig").cucumber_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		cucumber = {
			features = { "e2e/features/*.feature" },
			glue = { "e2e/tests/**/*.rs" },
		},
	},
})

require("lspconfig").html.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").cssls.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").ts_ls.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").rust_analyzer.setup({
	on_attach = function(client, bufnr)
		vim.keymap.set("n", "gO", function()
			vim.lsp.buf_request(
				vim.api.nvim_get_current_buf(),
				"experimental/externalDocs",
				vim.lsp.util.make_position_params(0, client.offset_encoding or "utf-8"),
				function(err, url)
					if not err and url then
						vim.ui.open(url)
					end
				end
			)
		end)

		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			procMacro = {
				enable = true,
				ignored = {
					leptos_macro = {
						-- optional: --
						-- "component", --
						"server",
					},
				},
			},
		},
	},
})

-- Workaround for rust_analyzer canceling requests
-- https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
	local default_diagnostic_handler = vim.lsp.handlers[method]
	vim.lsp.handlers[method] = function(err, result, context, config)
		if err ~= nil and err.code == -32802 then
			return
		end

		return default_diagnostic_handler(err, result, context, config)
	end
end

require("lspconfig").taplo.setup({
	on_attach = on_attach,
	capabilites = capabilities,
	cmd = { "tombi", "lsp" },
	root_markers = { ".git" },
	filetypes = { "toml" },
})

require("lspconfig").tinymist.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		exportPdf = "onSave", -- Choose onType, onSave or never.
		formatterMode = "typstyle",
	},
})

require("lspconfig").tailwindcss.setup({
	on_attach = function(client, bufnr)
		-- For highlighting tailwindcss colors, e.g. text-white
		require("tailwindcss-colors").buf_attach(bufnr)

		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
	root_dir = function(fname)
		local util = require("lspconfig.util")
		return util.root_pattern("tailwind.config.js", ".tailwind.config.js")(fname)
	end,
	filetypes = {
		"rust",
		"html",
	},
	init_options = {
		userLanguages = {
			rust = "html",
		},
	},
	handlers = {
		["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
			vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
		end,
	},
	settings = {
		experimental = {
			classRegex = {
				[[class= "([^"]*)]],
				[[class: "([^"]*)]],
				'~H""".*class="([^"]*)".*"""',
				'~F""".*class="([^"]*)".*"""',
			},
		},
		includeLanguages = {
			rust = "html",
		},
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
		},
	},
})

require("neodev").setup()
require("lspconfig").lua_ls.setup({
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
	},
})

require("lspconfig").nil_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixfmt" },
			},
		},
	},
})

require("lspconfig").marksman.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").harper_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
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
			terminating_conjunctions = true,
		},
	},
})
