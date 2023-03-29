return {
	"jose-elias-alvarez/null-ls.nvim",
	opts = function(_, config)
		-- config variable is the default configuration table for the setup function call
		local null_ls = require("null-ls")

		-- Check supported formatters and linters
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
		config.sources = {
			null_ls.builtins.formatting.erb_format,
			null_ls.builtins.formatting.erb_lint,
			null_ls.builtins.formatting.fish_indent,
			null_ls.builtins.formatting.hclfmt,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.packer,
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.formatting.terraform_fmt,
		}
		return config -- return final config table
	end,
}
