return {
	-- temp fix https://github.com/LazyVim/LazyVim/issues/6039
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({ ensure_installed = { "lua_ls" } })
		end,
		dependencies = { "mason-org/mason.nvim" },
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason-lspconfig.nvim", "mason-org/mason.nvim" },
		config = function()
			-- require("lspconfig").lua_ls.setup({})
		end,
	},
}
