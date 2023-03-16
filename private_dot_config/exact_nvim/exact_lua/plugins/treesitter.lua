-- Override the configuration of LazyVim plugins
return {
	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"bash",
				"comment",
				"diff",
				"dockerfile",
				"fish",
				"go",
				"hcl",
				"help",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			})
		end,
	},
}
