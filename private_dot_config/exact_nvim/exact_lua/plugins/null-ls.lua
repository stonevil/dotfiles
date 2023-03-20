return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	opts = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local code_actions = null_ls.builtins.code_actions
		local completion = null_ls.builtins.completion
		return {
			debug = true,
			sources = {
				code_actions.gitsigns,
				code_actions.cspell,
				code_actions.gomodifytags,
				code_actions.refactoring,
				code_actions.shellcheck,
				diagnostics.ansiblelint,
				diagnostics.buf,
				diagnostics.checkmake,
				diagnostics.cmake_lint,
				diagnostics.commitlint,
				diagnostics.fish,
				diagnostics.gitlint,
				diagnostics.hadolint,
				diagnostics.revive,
				diagnostics.ruff,
				diagnostics.shellcheck,
				diagnostics.staticcheck,
				diagnostics.terraform_validate,
				diagnostics.tfsec,
				diagnostics.trail_space,
				diagnostics.yamllint,
				diagnostics.zsh,
				completion.luasnip,
				completion.spell,
				completion.tags,
				formatting.astyle,
				formatting.fish_indent,
				formatting.hclfmt,
				formatting.prettier,
				formatting.protolint,
				formatting.ruff,
				formatting.shellharden,
				formatting.sqlformat,
				formatting.stylua,
				formatting.taplo,
				formatting.terraform_fmt,
			},
		}
	end,
}
