return {
	"anaypurohit0907/superfile.nvim",
	main = "superfile",
	opts = { key = false },
	keys = {
		{
			"<leader>SF",
			function()
				require("superfile").open()
			end,
			mode = { "n", "t" },
			desc = "Open/Focus Superfile",
			silent = true,
		},
	},
}
