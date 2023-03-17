return {
	"ahmedkhalf/project.nvim",
	event = "VimEnter",
	opts = {
		exclude_dirs = { print((os.getenv("HOME")) .. "/Downloads"), print((os.getenv("HOME")) .. "/Desktop") },
		detection_methods = { "pattern", "lsp" },
		ignore_lsp = {},
		silent_chdir = false,
	},
	config = function(_, opts)
		require("project_nvim").setup(opts)
	end,
}
