return {
	"rebelot/terminal.nvim",
	config = function()
		require("terminal").setup()
	end,
}, {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			float_opts = {
				border = "single",
				title_pos = "left",
			},
		})
	end,
}
