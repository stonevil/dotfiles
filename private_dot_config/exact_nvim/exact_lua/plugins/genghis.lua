return {
	{
		"chrisgrieser/nvim-genghis",
		dependencies = {
			"stevearc/dressing.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-omni",
		},
		config = function()
			local keymap = vim.keymap.set
			local genghis = require("genghis")
			keymap("n", "<leader>gp", genghis.copyFilepath, { desc = "Copy File Path" })
			keymap("n", "<leader>gn", genghis.copyFilename, { desc = "Copy File Name" })
			keymap("n", "<leader>gx", genghis.chmodx, { desc = "Change File Mode" })
			keymap("n", "<leader>gr", genghis.renameFile, { desc = "Rename File" })
			keymap("n", "<leader>gm", genghis.moveAndRenameFile, { desc = "Move and Rename File" })
			keymap("n", "<leader>gn", genghis.createNewFile, { desc = "Create New File" })
			keymap("n", "<leader>gd", genghis.duplicateFile, { desc = "Duplicate File" })
			keymap("n", "<leader>gT", function()
				genghis.trashFile()
			end, { desc = "Trash File" })
			keymap("x", "<leader>gS", genghis.moveSelectionToNewFile, { desc = "Move Selection to New File" })
		end,
	},
}
