# qutebrowser configuration
#
# Symlink into place:   ln -sf ~/dotfiles/qutebrowser/config.py ~/.config/qutebrowser/config.py
# Reload without restart:  :config-source   (or ,c)
# Every option below can be inspected live with  :set  /  :help <option>.
#
# Targets qutebrowser 3.x (QtWebEngine 6 / Qt6). Ubuntu's apt package is stuck at
# 2.5.4 (Chromium 87, 2020); this config assumes the uv-installed 3.7.0 — see README.

config.load_autoconfig(False)  # config.py is the single source of truth; ignore :set writes

# ---------------------------------------------------------------------------
# Palette — Solarized Dark
# Hardcoded per-file by design; see docs/adr/0001-palette-hex-duplicated-per-config.md
# ---------------------------------------------------------------------------
base03 = "#002b36"  # terminal background
base02 = "#073642"  # UI background
base01 = "#586e75"  # comments / dim
base00 = "#657b83"
base0 = "#839496"  # body foreground
base1 = "#93a1a1"
base2 = "#eee8d5"
base3 = "#fdf6e3"  # bright foreground
yellow = "#b58900"
orange = "#cb4b16"
red = "#dc322f"
magenta = "#d33682"
violet = "#6c71c4"
blue = "#268bd2"
cyan = "#2aa198"
green = "#859900"

# ---------------------------------------------------------------------------
# Fonts — inherit the terminal's face
# ---------------------------------------------------------------------------
c.fonts.default_family = ["Terminess Nerd Font Mono", "monospace"]
c.fonts.default_size = "11pt"
c.fonts.hints = "bold 12pt Terminess Nerd Font Mono"

# ---------------------------------------------------------------------------
# Hints — the mouse replacement
#
# COLEMAK DH: the default chars ("asdfghjkl") are the QWERTY home row, which on
# Colemak DH scatters across the board. These are the letters your Colemak DH
# home row actually emits, so hints stay on the strongest fingers.
#   left hand:  a r s t   |   right hand:  n e i o
# Unlike hjkl this costs no vim muscle memory — hints are labels you read, not
# motions. Revert with:  c.hints.chars = "asdfghjkl"
# ---------------------------------------------------------------------------
c.hints.chars = "arstneio"
c.hints.uppercase = False
c.hints.border = f"1px solid {base03}"
c.colors.hints.bg = yellow
c.colors.hints.fg = base03
c.colors.hints.match.fg = green

# ---------------------------------------------------------------------------
# Editor integration — Ctrl-E in insert mode opens the field in Neovim
# ---------------------------------------------------------------------------
c.editor.command = [
    "ghostty",
    "-e",
    "nvim",
    "-c",
    "normal {line}G{column0}l",
    "{file}",
]
c.editor.encoding = "utf-8"

# ---------------------------------------------------------------------------
# Content / privacy
# ---------------------------------------------------------------------------
c.content.blocking.enabled = True
c.content.blocking.method = "both"  # Brave adblock (python-adblock) + hosts lists
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
]

c.content.autoplay = False
c.content.notifications.enabled = "ask"
c.content.geolocation = "ask"
c.content.pdfjs = True  # render PDFs inline instead of downloading

# Respect sites' own dark themes rather than force-inverting everything.
# Toggle hard dark-mode per-session with ,d (bound below).
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.bg = base03
c.colors.webpage.darkmode.enabled = False

# ---------------------------------------------------------------------------
# Behaviour
# ---------------------------------------------------------------------------
c.auto_save.session = True
c.confirm_quit = ["downloads"]
c.scrolling.smooth = False  # snappier, and matches nvim's instant feel
c.zoom.default = "100%"
c.input.insert_mode.auto_load = False  # don't auto-focus text fields on page load

c.downloads.location.directory = "~/Downloads"
c.downloads.position = "bottom"
c.downloads.remove_finished = 10000  # ms

c.tabs.position = "top"
c.tabs.show = "multiple"  # hide the bar when only one tab is open
c.tabs.title.format = "{audio}{index}: {current_title}"
c.tabs.last_close = "close"

c.completion.height = "40%"
c.completion.shrink = True

c.statusbar.show = "always"
c.statusbar.widgets = ["keypress", "url", "scroll", "history", "tabs", "progress"]

# ---------------------------------------------------------------------------
# Search engines — type  o gh qutebrowser  in the open prompt
# ---------------------------------------------------------------------------
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "g": "https://www.google.com/search?q={}",
    "gh": "https://github.com/search?q={}&type=repositories",
    "gi": "https://github.com/search?q={}&type=issues",
    "np": "https://www.npmjs.com/search?q={}",
    "py": "https://pypi.org/search/?q={}",
    "pd": "https://docs.python.org/3/search.html?q={}",
    "rs": "https://docs.rs/{}",
    "so": "https://stackoverflow.com/search?q={}",
    "mdn": "https://developer.mozilla.org/en-US/search?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "hf": "https://huggingface.co/models?search={}",
    "w": "https://en.wikipedia.org/w/index.php?search={}",
}

c.url.default_page = "about:blank"  # new empty tabs stay blank
c.url.start_pages = ["https://www.google.com"]  # also what :home / gh loads

# ---------------------------------------------------------------------------
# Key bindings
#
# Stock qutebrowser bindings are LEFT INTACT on purpose: nvim/init.lua uses
# vim's default hjkl/n/N/K despite Colemak DH typing, so keeping the same here
# means one set of motions across nvim, qutebrowser and every vim doc online.
# Everything below is additive and uses the free , prefix (no default binds on it).
# ---------------------------------------------------------------------------
config.bind(",c", "config-source ;; message-info 'config reloaded'")
config.bind(",C", "config-edit")
config.bind(",d", "config-cycle colors.webpage.darkmode.enabled ;; reload")
config.bind(",m", "spawn --detach mpv {url}")  # play current page in mpv
config.bind(";m", "hint links spawn --detach mpv {hint-url}")  # play a linked video
config.bind(",b", "config-cycle content.blocking.enabled ;; reload")
config.bind("xb", "config-cycle statusbar.show always never")
config.bind("xt", "config-cycle tabs.show always never")
config.bind("gh", "home")  # follows url.start_pages[0], same as the default <Ctrl-H>

# --- Optional: Colemak DH navigation ---------------------------------------
# Only enable if you ALSO remap nvim; mixing schemes is worse than either one.
# On Colemak DH the physical hjkl positions emit m/n/e/i, so:
# config.bind("m", "scroll left")
# config.bind("n", "scroll down")
# config.bind("e", "scroll up")
# config.bind("i", "scroll right")
# config.bind("k", "search-next")      # n is taken above
# config.bind("K", "search-prev")
# config.bind("h", "mode-enter insert")  # i is taken above
# config.unbind("j"); config.unbind("k"); config.unbind("l")

# ---------------------------------------------------------------------------
# Colors — Solarized Dark
# ---------------------------------------------------------------------------
# Completion menu
c.colors.completion.fg = base0
c.colors.completion.odd.bg = base03
c.colors.completion.even.bg = base02
c.colors.completion.category.fg = yellow
c.colors.completion.category.bg = base02
c.colors.completion.category.border.top = base02
c.colors.completion.category.border.bottom = base02
c.colors.completion.item.selected.fg = base3
c.colors.completion.item.selected.bg = blue
c.colors.completion.item.selected.border.top = blue
c.colors.completion.item.selected.border.bottom = blue
c.colors.completion.item.selected.match.fg = base3
c.colors.completion.match.fg = orange
c.colors.completion.scrollbar.fg = base0
c.colors.completion.scrollbar.bg = base03

# Status bar — mode is colour-coded so you always know where you are
c.colors.statusbar.normal.fg = base0
c.colors.statusbar.normal.bg = base03
c.colors.statusbar.insert.fg = base3
c.colors.statusbar.insert.bg = green
c.colors.statusbar.passthrough.fg = base3
c.colors.statusbar.passthrough.bg = violet
c.colors.statusbar.private.fg = base3
c.colors.statusbar.private.bg = magenta
c.colors.statusbar.command.fg = base0
c.colors.statusbar.command.bg = base02
c.colors.statusbar.command.private.fg = base3
c.colors.statusbar.command.private.bg = magenta
c.colors.statusbar.caret.fg = base3
c.colors.statusbar.caret.bg = violet
c.colors.statusbar.caret.selection.fg = base3
c.colors.statusbar.caret.selection.bg = blue
c.colors.statusbar.progress.bg = blue
c.colors.statusbar.url.fg = base0
c.colors.statusbar.url.error.fg = red
c.colors.statusbar.url.hover.fg = cyan
c.colors.statusbar.url.success.http.fg = yellow  # plain HTTP stands out
c.colors.statusbar.url.success.https.fg = green
c.colors.statusbar.url.warn.fg = orange

# Tabs
c.colors.tabs.bar.bg = base03
c.colors.tabs.odd.fg = base0
c.colors.tabs.odd.bg = base02
c.colors.tabs.even.fg = base0
c.colors.tabs.even.bg = base03
c.colors.tabs.selected.odd.fg = base3
c.colors.tabs.selected.odd.bg = blue
c.colors.tabs.selected.even.fg = base3
c.colors.tabs.selected.even.bg = blue
c.colors.tabs.pinned.odd.fg = base3
c.colors.tabs.pinned.odd.bg = cyan
c.colors.tabs.pinned.even.fg = base3
c.colors.tabs.pinned.even.bg = cyan
c.colors.tabs.pinned.selected.odd.fg = base3
c.colors.tabs.pinned.selected.odd.bg = blue
c.colors.tabs.pinned.selected.even.fg = base3
c.colors.tabs.pinned.selected.even.bg = blue
c.colors.tabs.indicator.start = yellow
c.colors.tabs.indicator.stop = green
c.colors.tabs.indicator.error = red
c.colors.tabs.indicator.system = "none"

# Downloads
c.colors.downloads.bar.bg = base03
c.colors.downloads.start.fg = base3
c.colors.downloads.start.bg = blue
c.colors.downloads.stop.fg = base3
c.colors.downloads.stop.bg = green
c.colors.downloads.error.fg = base3
c.colors.downloads.error.bg = red
c.colors.downloads.system.fg = "none"
c.colors.downloads.system.bg = "none"

# Messages
c.colors.messages.error.fg = base3
c.colors.messages.error.bg = red
c.colors.messages.error.border = red
c.colors.messages.warning.fg = base3
c.colors.messages.warning.bg = orange
c.colors.messages.warning.border = orange
c.colors.messages.info.fg = base0
c.colors.messages.info.bg = base02
c.colors.messages.info.border = base02

# Prompts
c.colors.prompts.fg = base0
c.colors.prompts.bg = base02
c.colors.prompts.border = f"1px solid {base01}"
c.colors.prompts.selected.fg = base3
c.colors.prompts.selected.bg = blue

# Keyhint popup (shows possible continuations mid-chord)
c.colors.keyhint.fg = base0
c.colors.keyhint.suffix.fg = yellow
c.colors.keyhint.bg = base02

# Context menu / tooltips
c.colors.contextmenu.menu.bg = base02
c.colors.contextmenu.menu.fg = base0
c.colors.contextmenu.selected.bg = blue
c.colors.contextmenu.selected.fg = base3
c.colors.contextmenu.disabled.bg = base02
c.colors.contextmenu.disabled.fg = base01
c.colors.tooltip.bg = base02
c.colors.tooltip.fg = base0
