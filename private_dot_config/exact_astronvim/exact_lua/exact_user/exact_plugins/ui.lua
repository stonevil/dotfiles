return {
	-- Transparense everywhere
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		priority = 1000,
		cmd = { "TransparentEnable", "TransparentDisable", "TransparentToggle" },
		opts = {},
		config = function(_, opts)
			require("transparent").setup(opts)
		end,
	},

	-- Color Scheme
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = (vim.fn.has("gui_running") == 0 and vim.g.transparent_enabled),
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

	-- Disable Catppuccin
	{ "catppuccin/nvim", name = "catppuccin", enabled = false },
	-- Disable Tokyonight
	{ "folke/tokyonight.nvim", name = "tokyonight", enabled = false },
}