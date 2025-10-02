return {
	"olrtg/nvim-emmet",
	ft = { "html", "css", "javascript", "javascriptreact", "typescriptreact" },
	config = function()
		-- Map the function for wrapping with abbreviation in both normal and visual modes.
		vim.keymap.set(
			{ "n", "v" },
			"<leader>n",
			require("nvim-emmet").wrap_with_abbreviation,
			{ desc = "Wrap with Emmet Abbreviation" }
		)
	end,
}
