return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {silent = true, desc = "[f]ind [f]iles"})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {silent = true, desc = "[f]ind with [g]rep"})
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {silent = true, desc = "[f]ind [o]ld files"})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind [h]elp tags' })

      require("telescope").load_extension("ui-select")
    end,
  },
}
