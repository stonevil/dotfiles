-- Override the configuration of LazyVim plugins
return {
	{ "nvim-lua/plenary.nvim" },
	{ "nacro90/numb.nvim", event = "BufReadPre", config = true },
}
