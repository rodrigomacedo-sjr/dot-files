return {
  "folke/snacks.nvim",
  opts = {
    -- The configuration for snacks' toggleable features can now be simplified.
    -- We are telling it to use Neovim's built-in keymap function.
    toggle = { map = vim.keymap.set },

    -- The rest of your options are fine
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },
  },
  -- This keys section is already correct and does not need to change
  keys = {
    {
      "<leader>nh",
      function()
        local snacks = require("snacks")
        if snacks.config.picker and snacks.config.picker.enabled then
          snacks.picker.notifications()
        else
          snacks.notifier.show_history()
        end
      end,
      desc = "[n]otification [h]istory",
    },
    {
      "<leader>nu",
      function()
        require("snacks").notifier.hide()
      end,
      desc = "[n]otifications, [undo]",
    },
  },
}
