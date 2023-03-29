-- set vim options here (vim.<first_key>.<second_key> = value)
return {
	opt = {
		relativenumber = true,
		number = true,
		spell = false,
		signcolumn = "yes",
		laststatus = 2,
		confirm = true,
		swapfile = false,
		backup = false,
		fileformats = "unix,dos,mac",
		backspace = "indent,eol,start",
		autoindent = true,
		shiftround = true,
		expandtab = false,
		shiftwidth = 2,
		tabstop = 2,
		wrap = true,
		linebreak = true,
		list = true,
		breakindent = true,
		breakindentopt = "shift:2,min:40,sbr",
		showbreak = ">> ",
		showtabline = 2,
		scrolloff = 4,
		sidescrolloff = 4,
		smartcase = true,
		wildignore = "*.bak,.hg,*.swp,__pycache__,/tmp/*,*.so,*.pyc,*.png,*.jpg,*.gif,*.jpeg,*.ico,*.pdf,*.wav,*.mp4,*.mp3,*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*.swp,*~,._*,_pycache_,.DS_Store,.vscode,.localized,.cache,node_modules,package-lock.json,yarn.lock,dist,.git",
	},
	g = {
		mapleader = " ", -- sets vim.g.mapleader
		autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
		cmp_enabled = true, -- enable completion at start
		autopairs_enabled = true, -- enable autopairs at start
		diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
		icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
		ui_notifications_enabled = true, -- disable notifications when toggling UI elements
		transparency = true,
	},
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
