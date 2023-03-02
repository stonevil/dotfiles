-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.laststatus = 2
vim.opt.confirm = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.fileformats = "unix,dos,mac"

vim.opt.backspace = "indent,eol,start"

vim.opt.autoindent = true
vim.opt.shiftround = true
vim.opt.expandtab = false

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = true

vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2,min:40,sbr"
vim.opt.showbreak = ">> "

vim.opt.showtabline = 2
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

vim.opt.smartcase = true

vim.opt.wildignore =
	"*.bak,.hg,*.swp,__pycache__,/tmp/*,*.so,*.pyc,*.png,*.jpg,*.gif,*.jpeg,*.ico,*.pdf,*.wav,*.mp4,*.mp3,*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*.swp,*~,._*,_pycache_,.DS_Store,.vscode,.localized,.cache,node_modules,package-lock.json,yarn.lock,dist,.git"