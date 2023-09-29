return {
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		config = true,
	},
}
