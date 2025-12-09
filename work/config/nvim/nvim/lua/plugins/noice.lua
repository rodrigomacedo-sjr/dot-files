return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  },
  keys = {
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>nl", function() require("noice").cmd("last") end, desc = "[n]oice [l]ast message" },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "[n]oice [h]istory" },
    { "<leader>na", function() require("noice").cmd("all") end, desc = "[n]oice [a]ll" },
    { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "[n]oice [d]ismiss" },
    { "<leader>nt", function() require("noice").cmd("pick") end, desc = "[n]oice [t]elescope" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "scroll forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "scroll backward", mode = {"i", "n", "s"}},
  },
  config = function(_, opts)
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
    require("noice").setup(opts)
  end,
}
