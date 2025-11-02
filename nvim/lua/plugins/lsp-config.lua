return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		build = ":MasonUpdate",
		config = true, -- = require("mason").setup()
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {
			automatic_installation = true,
			ensure_installed = {
				"gopls",
				"lua_ls",
				"basedpyright",
				"html",
				"cssls",
				"emmet_ls",
				"ts_ls",
				"clangd",
				"jdtls",
			},
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			-- capabilities (works with or without nvim-cmp)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok_cmp, cmp = pcall(require, "cmp_nvim_lsp")
			if ok_cmp then
				capabilities = cmp.default_capabilities(capabilities)
			end

			local function on_attach(_, bufnr)
				local map = function(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
				end
				map("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
				map("gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
				map("gr", function()
					vim.lsp.buf.references({ includeDeclaration = false })
				end, "[g]o to [r]eferences")
				map("gi", vim.lsp.buf.implementation, "[g]o to [i]mplementation")
				map("K", vim.lsp.buf.hover, "LSP: Hover")
			end

			local flags = { debounce_text_changes = 150 }

			local function enable(server, cfg)
				cfg = vim.tbl_deep_extend("force", {
					capabilities = capabilities,
					on_attach = on_attach,
					flags = flags,
				}, cfg or {})
				vim.lsp.config(server, cfg)
				vim.lsp.enable(server)
			end

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						gofumpt = true,
						staticcheck = true,
						analyses = {
							unusedparams = true,
							nilness = true,
							unusedwrite = true,
							shadow = true,
						},
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
			})
			vim.lsp.enable("gopls")

			-- Lua
			enable("lua_ls")

			-- Python
			enable("basedpyright", {
				settings = {
					python = {
						analysis = {
							diagnosticMode = "workspace",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			-- Web
			enable("html")
			enable("cssls")
			enable("emmet_ls")
			enable("ts_ls")

			-- C/C++
			enable("clangd", {
				cmd = { "clangd", "--background-index", "--clang-tidy" },
			})
		end,
	},
}
