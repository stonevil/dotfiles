return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		require("telescope").setup({
			extensions = {
				undo = {
					-- telescope-undo.nvim config, see below
				},
			},
		})
		require("telescope").load_extension("undo")
		vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "Find undo" })
	end,
}
