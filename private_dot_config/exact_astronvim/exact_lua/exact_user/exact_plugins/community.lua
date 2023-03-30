return {
	-- Add the community repository of plugin specifications
	"AstroNvim/astrocommunity",
	-- available plugins can be found at https://github.com/AstroNvim/astrocommunity
	{ import = "astrocommunity.debugging.nvim-bqf" },
	{ import = "astrocommunity.diagnostics.lsp_lines-nvim" },
	{ import = "astrocommunity.diagnostics.trouble-nvim" },
	{ import = "astrocommunity.editing-support.nvim-ts-rainbow2" },
	{ import = "astrocommunity.editing-support.todo-comments-nvim" },
	{ import = "astrocommunity.file-explorer.oil-nvim" },
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.pack.cmake" },
	{ import = "astrocommunity.pack.go" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.markdown" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.toml" },
	{ import = "astrocommunity.pack.yaml" },
}
