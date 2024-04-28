return {
	"xvzc/chezmoi.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
			callback = function()
				vim.schedule(require("chezmoi.commands.__edit").watch)
			end,
		})
		require("chezmoi").setup({
			-- your configurations
		})
	end,
}
