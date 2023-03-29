return {
	"akinsho/toggleterm.nvim",
	opts = function(_, config)
		require("toggleterm").setup({
			cmd = "/bin/zsh --login",
		})
	end,
}
