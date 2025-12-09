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
    { "rafamadriz/friendly-snippets", lazy = true },
  },

  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()

    local has_luasnip, luasnip = pcall(require, "luasnip")
    if has_luasnip then luasnip.config.setup({}) end

    return {
      enabled = function() return vim.bo.buftype ~= "prompt" and not vim.g.cmp_disable end,

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      completion = { completeopt = "menu,menuone,noinsert" },
      preselect = cmp.PreselectMode.None,

      snippet = {
        expand = function(args)
          if has_luasnip then luasnip.lsp_expand(args.body) end
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
        ["<C-f>"]     = cmp.mapping.scroll_docs(4),
        ["<C-n>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"]     = cmp.mapping.abort(),

        ["<CR>"]   = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        ["<C-y>"]  = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        ["<C-CR>"] = function(fallback) cmp.abort(); fallback() end,

        ["<C-c>"] = function(fallback)
          if cmp.visible() then cmp.abort() end
          fallback()
        end,

        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_luasnip and luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif has_luasnip and luasnip.jumpable(-1) then
            luasnip.jump(-1)
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
        format = function(_, item)
          local icons = {
            Text = "󰉿 ", Method = "󰆧 ", Function = "󰊕 ", Constructor = " ",
            Field = " ", Variable = "󰀫 ", Class = "󰠱 ", Interface = " ",
            Module = " ", Property = " ", Unit = " ", Value = "󰎠 ",
            Enum = " ", Keyword = "󰌋 ", Snippet = " ", Color = "󰏘 ",
            File = "󰈙 ", Reference = "󰈇 ", Folder = " ", EnumMember = " ",
            Constant = "󰏿 ", Struct = "󰙅 ", Event = " ", Operator = "󰆕 ",
            TypeParameter = "󰉺 ",
          }
          if icons[item.kind] then item.kind = icons[item.kind] .. item.kind end
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
      performance = { debounce = 60, throttle = 30, fetching_timeout = 200 },
    }
  end,

  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)

    local ok_vscode, loader = pcall(require, "luasnip.loaders.from_vscode")
    if ok_vscode then loader.lazy_load() end

    local ok_ap, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
    if ok_ap then cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done()) end
  end,
}

