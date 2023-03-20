-- Color Scheme
return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = false,
					styles = {
						comments = "italic",
						keywords = "bold",
					},
				},
				palettes = {
					duskfox = {
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

	-- Configure LazyVim to load colorscheme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "nordfox",
		},
	},

	-- Disable Catppuccin
	{ "catppuccin/nvim", name = "catppuccin", enabled = false },
	-- Disable Tokyonight
	{ "folke/tokyonight.nvim", name = "tokyonight", enabled = false },
}
