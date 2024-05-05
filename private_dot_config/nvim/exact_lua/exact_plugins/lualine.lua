return {
	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			-- PERF: we don't need this lualine require madness 🤷
			local lualine_require = require("lualine_require")
			lualine_require.require = require

			local icons = require("lazyvim.config").icons

			vim.o.laststatus = vim.g.lualine_laststatus

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },

					lualine_c = {
						LazyVim.lualine.root_dir(),
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ LazyVim.lualine.pretty_path() },
					},
					lualine_x = {
						-- stylua: ignore
						{
							function() return require("noice").api.status.command.get() end,
							cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
							color = LazyVim.ui.fg("Statement"),
						},
						-- stylua: ignore
						{
							function() return require("noice").api.status.mode.get() end,
							cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
							color = LazyVim.ui.fg("Constant"),
						},
						-- stylua: ignore
						{
							function() return "	" .. require("dap").status() end,
							cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
							color = LazyVim.ui.fg("Debug"),
						},
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = LazyVim.ui.fg("Special"),
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							local space_pat = [[\v^ +]]
							local tab_pat = [[\v^\t+]]
							local space_indent = vim.fn.search(space_pat, "nwc")
							local tab_indent = vim.fn.search(tab_pat, "nwc")
							local mixed = (space_indent > 0 and tab_indent > 0)
							local mixed_same_line
							if not mixed then
								mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
								mixed = mixed_same_line > 0
							end
							if not mixed then
								return ""
							end
							if mixed_same_line ~= nil and mixed_same_line > 0 then
								return "MI:" .. mixed_same_line
							end
							local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
							local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
							if space_indent_cnt > tab_indent_cnt then
								return "MI:" .. tab_indent
							else
								return "MI:" .. space_indent
							end
						end,
					},
				},
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},
}

