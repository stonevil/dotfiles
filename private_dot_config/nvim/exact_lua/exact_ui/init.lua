return {
	-- Transparency everywhere
	{
		"xiyaowong/transparent.nvim",
		cmd = { "TransparentEnable", "TransparentDisable", "TransparentToggle" },
		opts = {
			enable = vim.g.transparent_enabled,
			extra_groups = "all",
		},
		config = function(_, opts)
			require("transparent").setup(opts)
		end,
	},

	-- Colour schemes
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = vim.g.transparency,
					styles = {
						comments = "italic",
						keywords = "bold",
					},
				},
				palettes = {
					nordfox = {
						black = "#000000", -- Just black
						bg1 = "#000000", -- Black background
						bg0 = "#000000", -- Alt backgrounds (floats, statusline, ...)
						bg3 = "#121820", -- 55% darkened from stock
						sel0 = "#131b24", -- 55% darkened from stock
					},
				},
			})
			require("nightfox").load()
		end,
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				transparent = vim.g.transparency,
			})
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = vim.g.transparency,
			})
		end,
	},

	-- Configure LazyVim to load colorscheme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin-mocha",
		},
	},

	-- Disable Catppuccin
	-- { "catppuccin/nvim", name = "catppuccin", enabled = false },
	-- Disable Tokyonight
	-- { "folke/tokyonight.nvim", name = "tokyonight", enabled = false },
}
