return {
	"jiaoshijie/undotree",
	enabled = true,
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "<leader>T", "<cmd>lua require('undotree').toggle()<cr>" },
	},
}
