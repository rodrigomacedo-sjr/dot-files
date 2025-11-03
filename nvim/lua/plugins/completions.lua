return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"windwp/nvim-autopairs",
	},
	opts = function()
		local capabilities = (function()
			local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			if ok then
				return cmp_lsp.default_capabilities()
			end
			return vim.lsp.protocol.make_client_capabilities()
		end)()

		if type(vim.lsp) == "table" and type(vim.lsp.config) == "function" then
			pcall(vim.lsp.config, "*", { capabilities = capabilities })
		end

		pcall(function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")
			util.default_config = vim.tbl_deep_extend("force", util.default_config, { capabilities = capabilities })
		end)

		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		local cmp = require("cmp")
		local defaults = require("cmp.config.default")()

		local has_luasnip, luasnip = pcall(require, "luasnip")
		if has_luasnip then
			luasnip.config.setup({})
		end

		local auto_select = true

		local M = {
			auto_brackets = {},

			completion = {
				completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
			},
			preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,

			snippet = {
				expand = function(args)
					if has_luasnip then
						luasnip.lsp_expand(args.body)
					end
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-Space>"] = cmp.mapping.complete(),

				["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),

				["<C-CR>"] = function(fallback)
					cmp.abort()
					fallback()
				end,
				["<Tab>"] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					elseif require("luasnip").expand_or_jumpable() then
						require("luasnip").expand_or_jump()
					else
						fallback()
					end
				end,
				["<S-Tab>"] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
					elseif require("luasnip").jumpable(-1) then
						require("luasnip").jump(-1)
					else
						fallback()
					end
				end,
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			}, {
				{ name = "buffer" },
			}),

			formatting = {
				format = function(entry, item)
					local icons = {
						Text = "󰉿 ",
						Method = "󰆧 ",
						Function = "󰊕 ",
						Constructor = " ",
						Field = " ",
						Variable = "󰀫 ",
						Class = "󰠱 ",
						Interface = " ",
						Module = " ",
						Property = " ",
						Unit = " ",
						Value = "󰎠 ",
						Enum = " ",
						Keyword = "󰌋 ",
						Snippet = " ",
						Color = "󰏘 ",
						File = "󰈙 ",
						Reference = "󰈇 ",
						Folder = " ",
						EnumMember = " ",
						Constant = "󰏿 ",
						Struct = "󰙅 ",
						Event = " ",
						Operator = "󰆕 ",
						TypeParameter = "󰉺 ",
					}
					if icons[item.kind] then
						item.kind = icons[item.kind] .. item.kind
					end

					local widths = {
						abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
						menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
					}
					for key, width in pairs(widths) do
						if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
							item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
						end
					end
					return item
				end,
			},

			experimental = {
				ghost_text = vim.g.ai_cmp and { hl_group = "CmpGhostText" } or false,
			},

			sorting = defaults.sorting,
		}

		pcall(function()
			cmp.event:on("confirm_done", function(evt)
				local bufnr = vim.api.nvim_get_current_buf()
				local ft = vim.bo[bufnr].filetype
				local list = M.auto_brackets or {}
				local enabled = list[ft] or vim.tbl_contains(list, ft)
				if not enabled then
					return
				end
				local kind = evt and evt.entry and evt.entry:get_kind()
				if kind == cmp.lsp.CompletionItemKind.Function or kind == cmp.lsp.CompletionItemKind.Method then
					local row, col = unpack(vim.api.nvim_win_get_cursor(0))
					local line = vim.api.nvim_get_current_line()
					local after = line:sub(col + 1, col + 1)
					if after ~= "(" then
						vim.api.nvim_set_current_line(line:sub(1, col) .. "()" .. line:sub(col + 1))
						vim.api.nvim_win_set_cursor(0, { row, col + 1 })
					end
				end
			end)
		end)

		pcall(function()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end)

		return M
	end,
}
