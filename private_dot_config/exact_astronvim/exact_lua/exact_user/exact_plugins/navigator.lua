return {
	{
		"numToStr/Navigator.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("Navigator").setup()
			vim.keymap.set({ "n", "t" }, "<A-Left>", "<CMD>NavigatorLeft<CR>")
			vim.keymap.set({ "n", "t" }, "<A-Right>", "<CMD>NavigatorRight<CR>")
			vim.keymap.set({ "n", "t" }, "<A-Up>", "<CMD>NavigatorUp<CR>")
			vim.keymap.set({ "n", "t" }, "<A-Down>", "<CMD>NavigatorDown<CR>")
			vim.keymap.set({ "n", "t" }, "<A-p>", "<CMD>NavigatorPrevious<CR>")
		end,
	},
}
