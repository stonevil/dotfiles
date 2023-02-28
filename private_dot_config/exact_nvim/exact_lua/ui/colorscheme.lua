-- Color Scheme
return {
	{
		"stonevil/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").setup({
				-- Telesccope custom configs.
				telescope = {
					-- Available styles: `classic`, `flat`.
					style = "classic",
				},
				transparent_bg = true,
			})
			require("nordic").load()
		end,
	},

	-- Configure LazyVim to load colorscheme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "nordic",
		},
	},

	-- Disable Catppuccin
	{ "catppuccin/nvim", name = "catppuccin", enabled = false },
	-- Disable Tokyonight
	{ "folke/tokyonight.nvim", name = "tokyonight", enabled = false },
}
