return {
	"folke/snacks.nvim",
	opts = {
		toggle = { map = vim.keymap.set },

		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		scope = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = true },
		---@class snacks.dashboard.Config
		dashboard = {
			sections = {
				{
					section = "terminal",
					cmd = "chafa ~/Pictures/wallpapers/wave.jpg --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
					height = 20,
					padding = 1,
				},
				{
					pane = 2,
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
		},
	},
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
			desc = "[n]otifications, [u]ndo",
		},
	},
}
