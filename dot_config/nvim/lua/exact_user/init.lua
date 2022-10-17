--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = true, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme to use
  colorscheme = "ayu",

  -- Override highlight groups in any theme
  highlights = {
    -- duskfox = { -- a table of overrides/changes to the default
    --   Normal = { bg = "#000000" },
    -- },
    default_theme = function(highlights) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      wildignore = {
        "*.bak",
        "*.hg",
        "*.swp",
        "__pycache__",
        "/tmp/*",
        "*.so",
        "*.pyc",
        "*.png",
        "*.jpg",
        "*.gif",
        "*.jpeg",
        "*.ico",
        "*.pdf",
        "*.wav",
        "*.mp4",
        "*.mp3",
        "*.o",
        "*.out",
        "*.obj",
        ".git",
        "*.rbc",
        "*.rbo",
        "*.class",
        ".svn",
        "CVS",
        "*.gem",
        "*.zip",
        "*.tar.gz",
        "*.tar.bz2",
        "*.rar",
        "*.tar.xz",
        "/vendor/gems/*",
        "*/vendor/cache/*",
        "*/.bundle/*",
        "*/.sass-cache/*",
        "*.swp",
        "*~,._*",
        ".DS_Store",
        ".vscode",
        ".localized cache",
        "node_modules",
        "package-lock.json",
        "yarn.lock",
        "dist",
        ".git",
      },
      relativenumber = true, -- sets vim.opt.relativenumber
      clipboard = "unnamedplus", -- sets vim.opt.clipboard
      smartindent = true,
      copyindent = true,
      preserveindent = true,
      expandtab = false,
      softtabstop = 2,
      shiftwidth = 2,
      tabstop = 2,
      wrap = true,
      scrolloff = 4, -- Keep 4 lines above or below the cursor when scrolling
      fileformats = { "unix", "dos", "mac" }, -- Prefer Unix over Windows over OS 9 formats
      autoread = true, -- Automatically read changed files
      autowrite = true, -- Automatically save before :next, :make etc.
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      catppuccin_flavour = "mocha",
    },
  },
  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,

  -- Set dashboard header
  header = {},

  -- Default theme configuration
  default_theme = {
    -- set the highlight style for diagnostic messages
    diagnostics_style = { italic = true },
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
      -- Example disabling formatting for a specific language server
      -- gopls = { -- override table for require("lspconfig").gopls.setup({...})
      --   on_attach = function(client, bufnr)
      --     client.resolved_capabilities.document_formatting = false
      --   end
      -- }
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- Configure plugins
  plugins = {
    init = {
      {
        -- Clipboard manager
        "AckslD/nvim-neoclip.lua",
        after = "telescope.nvim",
        module = "telescope._extensions.neoclip",
        requires = {
          { "nvim-telescope/telescope.nvim" },
          { "kkharji/sqlite.lua", module = "sqlite" },
        },
        config = function()
          require("telescope").load_extension "neoclip"
          require("neoclip").setup {
            history = 1000,
            enable_persistent_history = true,
            db_path = vim.fn.stdpath "data" .. "/databases/neoclip.sqlite3",
          }
        end,
      },
      {
        "benfowler/telescope-luasnip.nvim",
        after = "telescope.nvim",
        module = "telescope._extensions.luasnip",
        requires = {
          { "nvim-telescope/telescope.nvim" },
          { "L3MON4D3/LuaSnip" },
          { "rafamadriz/friendly-snippets" },
        },
        config = function() require("telescope").load_extension "luasnip" end,
      },
      {
        -- Better marks
        -- mx              Set mark x
        -- m,              Set the next available alphabetical (lowercase) mark
        -- m;              Toggle the next available mark at the current line
        -- dmx             Delete mark x
        -- dm-             Delete all marks on the current line
        -- dm<space>       Delete all marks in the current buffer
        -- m]              Move to next mark
        -- m[              Move to previous mark
        -- m:              Preview mark. This will prompt you for a specific mark to
        --                 preview; press <cr> to preview the next mark.
        --
        -- m[0-9]          Add a bookmark from bookmark group[0-9].
        -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
        -- m}              Move to the next bookmark having the same type as the bookmark under
        --                 the cursor. Works across buffers.
        -- m{              Move to the previous bookmark having the same type as the bookmark under
        --                 the cursor. Works across buffers.
        -- dm=             Delete the bookmark under the cursor.
        "chentoast/marks.nvim",
      },
      {
        -- surr*ound_words           ysiw)           (surround_words)
        -- *make strings             ys$"            "make strings"
        -- [delete ar*ound me!]      ds]             delete around me!
        -- remove <b>HTML t*ags</b>  dst             remove HTML tags
        -- 'change quot*es'          cs'"            "change quotes"
        -- <b>or tag* types</b>      csth1<CR>       <h1>or tag types</h1>
        -- delete(functi*on calls)   dsf             function calls
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit for the latest features
        config = function() require("nvim-surround").setup {} end,
      },
      -- {
      --   -- Programming, Testing, Debugging
      --   "mfussenegger/nvim-dap",
      --   module = "dap",
      --   config = require "user.plugins.dap",
      --   requires = {
      --     {
      --       "rcarriga/nvim-dap-ui",
      --       after = "nvim-dap",
      --       config = require "user.plugins.dapui",
      --     },
      --     {
      --       "theHamsta/nvim-dap-virtual-text",
      --       after = "nvim-dap",
      --       config = function() require("nvim-dap-virtual-text").setup(require "user.plugins.dap-virtual-text") end,
      --     },
      --     {
      --       "nvim-telescope/telescope-dap.nvim",
      --       after = "telescope.nvim",
      --       module = "telescope._extensions.dap",
      --       config = function() require("telescope").load_extension "dap" end,
      --     },
      --   },
      -- },
      -- {
      -- {
      --   -- Debug Adapter for Lua
      --   "jbyuki/one-small-step-for-vimkind",
      --   requires = { "nvim-dap" },
      --   module = "osv",
      -- },
      --   -- Go programming
      --   "ray-x/go.nvim",
      --   ft = "go",
      --   config = function() require("go").setup(require "user.plugins.go") end,
      -- },
      {
        -- Reopen same place
        "ethanholz/nvim-lastplace",
        config = function()
          require("nvim-lastplace").setup {
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
            lastplace_open_folds = true,
          }
        end,
      },
      -- AerialToggle[!]             left/right/float  Open or close the aerial window. With [!] cursor stays in current window
      -- AerialOpen[!]               left/right/float  Open the aerial window. With [!] cursor stays in current window
      -- AerialOpenAll                                 Open an aerial window for each visible window
      -- AerialClose                                   Close the aerial window
      -- AerialCloseAll                                Close all visible aerial windows
      -- AerialCloseAllButCurrent                      Close all visible aerial windows except for the focused one
      -- AerialPrev                  N=1               Jump backwards N symbols
      -- AerialNext                  N=1               Jump forwards N symbols
      -- AerialPrevUp                N=1               Jump up the tree N levels, moving backwards
      -- AerialNextUp                N=1               Jump up the tree N levels, moving forwards
      -- AerialGo                    N=1, v/h          Jump to the Nth symbol
      -- AerialTreeOpen[!]                             Expand tree at current location. [!] makes it recursive.
      -- AerialTreeClose[!]                            Collapse tree at current location. [!] makes it recursive.
      -- AerialTreeToggle[!]                           Toggle tree at current location. [!] makes it recursive.
      -- AerialTreeOpenAll                             Open all tree nodes
      -- AerialTreeCloseAll                            Collapse all tree nodes
      -- AerialTreeSetCollapseLevel  N                 Collapse symbols at a depth greater than N (0 collapses all)
      -- AerialTreeSyncFolds                           Sync code folding with current tree state
      -- AerialInfo                                    Print out debug info related to aerial
      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup {
            dim_inactive = {
              enabled = false,
              shade = "dark",
              percentage = 0.15,
              transparent_background = true,
            },
          }
        end,
      },
      {
        "olimorris/onedarkpro.nvim",
        config = function()
          require("onedarkpro").setup {
            theme = "onedark_dark",
            options = {
              transparency = false,
            },
          }
        end,
      },
      {
        "Shatur/neovim-ayu",
        config = function()
          require("ayu").setup {
            mirage = false,
            overrides = {},
          }
        end,
      },
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- Add plugins, the packer syntax without the "use"
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
    },
    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup functino call
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
      }
      -- set up null-ls's on_attach function
      -- NOTE: You can remove this on attach function to disable format on save
      config.on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table to use in require("null-ls").setup(config)
    end,
    treesitter = { -- overrides `require("treesitter").setup(...)`
      ensure_installed = { "lua" },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = { "sumneko_lua" },
    },
    -- use mason-tool-installer to configure DAP/Formatters/Linter installation
    ["mason-tool-installer"] = { -- overrides `require("mason-tool-installer").setup(...)`
      ensure_installed = { "prettier", "stylua" },
    },
    packer = { -- overrides `require("packer").setup(...)`
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
        },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })

    -- Set up custom filetypes
    vim.filetype.add {
      extension = {
        sshconfig = "sshconfig",
      },
      filename = {
        ["Brewfile"] = "ruby",
        ["Vagranfile"] = "ruby",
      },
      pattern = {
        ["Dockerfile.*"] = "Dockerfile",
        ["~/.kube/config"] = "yaml",
        ["*/playbooks/*.yml"] = "yaml.ansible",
        ["*/playbooks/roles/*/*.yml"] = "yaml.ansible",
        ["*/templates/*.yaml"] = "yaml.gotexttmpl",
        ["*/deployment/*.yaml"] = "yaml.gotexttmpl",
        ["*/templates/*.tpl"] = "yaml.gotexttmpl",
        ["*/deployment/*.tpl"] = "yaml.gotexttmpl",
      },
    }
  end,
}

return config
