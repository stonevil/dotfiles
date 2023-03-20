-- Override the configuration of LazyVim plugins
return {
	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"arduino",
				"bash",
				"c",
				"cmake",
				"comment",
				"diff",
				"dockerfile",
				"fish",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"go",
				"hcl",
				"help",
				"html",
				"javascript",
				"jq",
				"json",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"ruby",
				"rust",
				"sql",
				"terraform",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			})
		end,
	},
}
