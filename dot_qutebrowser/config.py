# Load config.py settings
config.load_autoconfig(False)

# Aliases for commands
c.aliases = {"q": "quit", "w": "session-save", "wq": "quit --save"}

# Editor
c.editor.command = ["nvim", "{}"]

# Always restore sites
c.auto_save.session = True

# Completion menu height
c.completion.height = "20%"

# Confirm quit if downloading
c.confirm_quit = ["downloads"]

# Download locations
c.downloads.location.directory = "~/Downloads"

config.load_autoconfig()

import catppuccin
catppuccin.setup(c, 'mocha')

c.url.start_pages = "about:blank"

c.qt.args = ["force-dark-mode", "dark"]
c.colors.webpage.darkmode.enabled = True

c.tabs.indicator.width = 0
c.tabs.padding = {"bottom": 10, "top": 10, "left": 20, "right": 20}
c.tabs.favicons.show = "always"
c.tabs.show = "multiple"
c.zoom.default = "100%"

c.fonts.default_family = "Iosevka Nerd Font"
c.fonts.default_size = "16pt"
