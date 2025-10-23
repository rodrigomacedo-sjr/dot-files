return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "[b]uffer [p]in" },
    { "<leader>bd", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "[b]uffer [d]elete unpinned" },
  },
  opts = function()
    local snacks = require("snacks")

    return {
      options = {
        close_command = function(n) snacks.bufdelete(n) end,
        right_mouse_command = function(n) snacks.bufdelete(n) end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = { Error = " ", Warn = " " }
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
        get_element_icon = function(element)
          local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = true })
          return icon, hl
        end,
      },
    }
  end,
}
