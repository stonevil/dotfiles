return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		event = "BufReadPre",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },

			-- More autocompletion
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			local lsp = require("lsp-zero").preset({})
			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)
			lsp.default_keymaps({
				buffer = bufnr,
				preserve_mappings = false,
			})
			-- (Optional) Configure lua language server for neovim
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
			lsp.setup()
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("cmp").setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{
						name = "buffer",
						option = {
							get_bufnrs = function()
								local bufs = {}
								for _, win in ipairs(vim.api.nvim_list_wins()) do
									bufs[vim.api.nvim_win_get_buf(win)] = true
								end
								return vim.tbl_keys(bufs)
							end,
						},
					},
				},
			})
			-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- The following example advertise capabilities to `clangd`.
			require("lspconfig").clangd.setup({
				capabilities = capabilities,
			})
		end,
	},
}
