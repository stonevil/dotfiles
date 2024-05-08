return {
	{
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
			vim.keymap.set({ "n", "t" }, "<A-Left>", "<CMD>NavigatorLeft<CR>")
			vim.keymap.set({ "n", "t" }, "<A-Right>", "<CMD>NavigatorRight<CR>")
			vim.keymap.set({ "n", "t" }, "<A-Up>", "<CMD>NavigatorUp<CR>")
			vim.keymap.set({ "n", "t" }, "<A-Down>", "<CMD>NavigatorDown<CR>")
			vim.keymap.set({ "n", "t" }, "<A-p>", "<CMD>NavigatorPrevious<CR>")
		end,
	},
	-- {
	-- 	"aserowy/tmux.nvim",
	-- 	config = function()
	-- 		require("tmux").setup({
	-- 			navigation = {
	-- 				enable_default_keybindings = false,
	-- 			},
	-- 			resize = {
	-- 				enable_default_keybindings = false,
	-- 				resize_step_x = 4,
	-- 				resize_step_y = 4,
	-- 			},
	-- 			vim.keymap.set({ "n", "t" }, "<A-Left>", '<cmd>lua require("tmux").move_left()<cr>'),
	-- 			vim.keymap.set({ "n", "t" }, "<A-Right>", '<cmd>lua require("tmux").move_right()<cr>'),
	-- 			vim.keymap.set({ "n", "t" }, "<A-Up>", '<cmd>lua require("tmux").move_up()<cr>'),
	-- 			vim.keymap.set({ "n", "t" }, "<A-Down>", '<cmd>lua require("tmux").move_down()<cr>'),
	-- 			vim.keymap.set({ "n", "t" }, "<A-S-Left>", '<cmd>lua require("tmux").resize_left()<cr>'),
	-- 			vim.keymap.set({ "n", "t" }, "<A-S-Right>", '<cmd>lua require("tmux").resize_right()<cr>'),
	-- 			vim.keymap.set({ "n", "t" }, "<A-S-Up>", '<cmd>lua require("tmux").resize_up()<cr>'),
	-- 			vim.keymap.set({ "n", "t" }, "<A-S-Down>", '<cmd>lua require("tmux").resize_down()<cr>'),
	-- 		})
	-- 	end,
	-- },
}
