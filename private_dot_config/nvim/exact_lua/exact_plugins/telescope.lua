return {
	-- change some telescope options and a keymap to browse plugin files
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>bt", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffers" },
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
		},
		-- change some options
		opts = {
			defaults = {
				layout_config = {
					width = 0.9,
					prompt_position = "top",
					preview_cutoff = 60,
					horizontal = { mirror = false },
					vertical = { mirror = false },
				},
				layout_strategy = "horizontal",
				sorting_strategy = "ascending",
				winblend = 0,
				path_display = { "smart" },
				file_ignore_patterns = { ".git/", "node_modules" },
				pickers = {
					find_files = {
						hidden = true,
					},
					grep_string = {
						additional_args = { "--hidden" },
					},
					live_grep = {
						additional_args = { "--hidden" },
					},
				},
			},
		},
	},

	-- add telescope tabs
	{
		"LukasPietzschmann/telescope-tabs",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope-tabs").setup({
				show_preview = true,
			})
		end,
	},

	{
		"debugloop/telescope-undo.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		keys = {
			{
				"<leader>su",
				"<cmd>Telescope undo<cr>",
				desc = "Undo history",
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},

	-- enable telescope plugins
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
				require("telescope").load_extension("ui-select")
				require("telescope").load_extension("tabs")
			end,
		},
	},
}
