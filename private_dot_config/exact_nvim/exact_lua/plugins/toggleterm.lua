return {
	"akinsho/toggleterm.nvim",
	module = true,
	cmd = "ToggleTerm",
	-- event = { "BufReadPost", "BufNewFile" },
	config = function()
		local toggleterm = require("toggleterm")

		toggleterm.setup({
			size = function(term)
				if term.direction == "horizontal" then
					return vim.o.lines * 0.4
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				elseif term.direction == "float" then
					return vim.o.columns * 0.9
				end
			end,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = false,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			autochdir = true,
			highlights = {
				NormalFloat = {
					link = "Normal",
				},
				FloatBorder = {
					link = "FloatBorder",
				},
			},
			float_opts = {
				border = "single",
				width = function()
					return math.floor(vim.o.columns * 0.9)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
				winblend = 0,
			},
		})
	end,
}
