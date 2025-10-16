return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			ensure_installed = {
				"clangd",
				"ts_ls",
				"html",
				"cssls",
				"emmet_language_server",
				"basedpyright",
				"lua_ls",
				"gopls",
				"jdtls",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
				end
				map("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
				map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
				map("gr", function()
					vim.lsp.buf.references({ includeDeclaration = false })
				end, "[g]oto [r]eferences")
				map("gi", vim.lsp.buf.implementation, "[g]oto [i]mplementations")

				client.server_capabilities.documentFormattingProvider = true
			end

			local lsp_flags = {
				allow_incremental_sync = true,
				debounce_text_changes = 150,
			}

			-- tiny helper to cut repetition
			local function enable(server, cfg)
				cfg = cfg or {}
				cfg.capabilities = capabilities
				cfg.on_attach = on_attach
				cfg.flags = lsp_flags
				vim.lsp.config(server, cfg) -- merges with defaults from nvim-lspconfig's lsp/<server>.lua
				vim.lsp.enable(server) -- auto-starts when filetype & root markers match
			end

			-- JavaScript / TypeScript
			enable("ts_ls")

			-- HTML / CSS / Emmet
			enable("html")
			enable("cssls")
			enable("emmet_language_server")

			-- Python (basedpyright)
			enable("basedpyright", {
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			-- Lua
			enable("lua_ls")

			-- Go (gopls) — improved: code actions, hover, rename, formatting, linting
	  enable("gopls", {
		  settings = {
			  gopls = {
				  completeUnimported = true,
				  usePlaceholders = true,
				  gofumpt = true, -- formatting (organizes imports on format)
				  staticcheck = true, -- linting
				  analyses = {
					  unusedparams = true,
					  nilness = true,
					  shadow = true,
					  unreachable = true,
					  unusedwrite = true,
				  },
			  },
		  },
	  })

	  -- C/C++ (clangd)
	  enable("clangd", {
		  cmd = { "clangd", "--background-index", "--clang-tidy" },
		  init_options = {
			  clangdFileStatus = true,
			  fallbackFlags = { "--std=c++98" },
		  },
	  })

	  -- Java
	  enable("jdtls", { settings = { java = {} } })
  end,  },
}
