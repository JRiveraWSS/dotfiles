from typing import List
from os.path import expanduser

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# --------------------------------------------------------------
# Core variables
# --------------------------------------------------------------
mod = "mod4"
terminal = "ghostty"
browser = "google-chrome"
launcher = "rofi -show drun"
file_manager = "thunar"
powermenu = expanduser("~/dotfiles/scripts/powermenu.sh")

# --------------------------------------------------------------
# Tokyonight Storm Palette
# --------------------------------------------------------------
colors = {
    "fg": "#c0caf5",
    "bg": "#24283b",
    "bg_dark": "#1f2335",
    "blue": "#7aa2f7",
    "cyan": "#7dcfff",
    "magenta": "#bb9af7",
    "green": "#9ece6a",
    "yellow": "#e0af68",
    "red": "#f7768e",
    "comment": "#565f89",
    "grey": "#414868",
}

# Convenience aliases
accent = colors["cyan"]
inactive = colors["comment"]

# --------------------------------------------------------------
# Keys
# --------------------------------------------------------------
keys = [
    # Focus
    Key([mod], "h", lazy.layout.left(), desc="Focus left"),
    Key([mod], "l", lazy.layout.right(), desc="Focus right"),
    Key([mod], "j", lazy.layout.down(), desc="Focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Next window"),
    # Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move up"),
    # Resize
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Normalize"),
    # Layouts & windows
    Key([mod], "Tab", lazy.next_layout(), desc="Next layout"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "m", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    # Launchers
    Key([mod], "Return", lazy.spawn(terminal), desc="Open terminal"),
    Key([mod], "b", lazy.spawn(browser), desc="Open browser"),
    Key([mod], "r", lazy.spawn(launcher), desc="Launcher"),
    Key([mod], "e", lazy.spawn(file_manager), desc="File manager"),
    Key([mod, "shift"], "e", lazy.spawn(powermenu), desc="Power menu"),
    # Qtile
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # System
    Key([], "Print", lazy.spawn("flameshot gui"), desc="Screenshot"),
    # Volume control
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Increase volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Decrease volume"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Mute/Unmute"),
    # Brightness control
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%"), desc="Increase brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-"), desc="Decrease brightness"),
]

# --------------------------------------------------------------
# Groups
# --------------------------------------------------------------
group_names = [
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
]

# Create groups simply with their display names. Default layouts are set globally via layouts list.
groups = [Group(name) for name in group_names]

for i, name in enumerate(group_names, 1):
    keys.extend(
        [
            Key(
                [mod],
                str(i),
                lazy.group[name].toscreen(),
                desc=f"Switch to group {name}",
            ),
            Key(
                [mod, "shift"],
                str(i),
                lazy.window.togroup(name),
                desc=f"Move window to group {name}",
            ),
        ]
    )

# --------------------------------------------------------------
# Layouts
# --------------------------------------------------------------
layout_theme = {
    "border_focus": accent,
    "border_normal": colors["bg_dark"],
    "border_width": 2,
    "margin": 6,
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(),
    layout.Floating(**layout_theme),
]

floating_layout = layout.Floating(
    border_focus=accent,
    border_normal=colors["bg_dark"],
    border_width=2,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(title="Confirmation"),
        Match(title="Qalculate!"),
        Match(wm_class="ssh-askpass"),
        Match(wm_class="pavucontrol"),
        Match(wm_class="Blueman-manager"),
        Match(wm_class="feh"),
    ],
)

# --------------------------------------------------------------
# Widgets & Bar
# --------------------------------------------------------------
widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=17,
    padding=8,
    foreground=colors["fg"],
)
extension_defaults = widget_defaults.copy()


def top_bar():
    return bar.Bar(
        [
            # Left Section: Workspaces & Layout
            widget.Spacer(length=10),
            widget.GroupBox(
                highlight_method="block",
                highlight_color=[colors["bg_dark"], colors["bg_dark"]],
                active=colors["fg"],
                inactive=inactive,
                this_current_screen_border=accent,
                this_screen_border=colors["bg"],
                other_current_screen_border=colors["grey"],
                other_screen_border=colors["grey"],
                urgent_border=colors["red"],
                padding=10,
                rounded=True,
                hide_unused=True,
                borderwidth=0,
                disable_drag=True,
                fontsize=18,
                block_highlight_text_color=colors["bg"],
            ),
            widget.Sep(
                linewidth=0,
                padding=16,
            ),
            widget.CurrentLayout(
                mode="icon",
                padding=10,
                foreground=accent,
                fontsize=19,
            ),
            widget.Sep(
                linewidth=0,
                padding=12,
            ),
            widget.WindowName(
                format="{name}",
                max_chars=55,
                empty_group_string="Desktop",
                foreground=colors["cyan"],
                padding=12,
                fontsize=16,
            ),
            widget.Spacer(),
            # Center Section: Clock (Prominent)
            widget.TextBox(
                text="",
                foreground=colors["bg"],
                fontsize=32,
                padding=0,
            ),
            widget.Clock(
                format="  %a %b %d   %H:%M",
                foreground=colors["fg"],
                background=colors["bg"],
                padding=16,
                fontsize=16,
            ),
            widget.TextBox(
                text="",
                foreground=colors["bg"],
                fontsize=32,
                padding=0,
            ),
            widget.Spacer(),
            # Right Section: System Controls
            widget.Backlight(
                backlight_name="nvidia_wmi_ec_backlight",
                fmt="󰃞 {}",
                foreground=colors["yellow"],
                padding=10,
                fontsize=17,
            ),
            widget.Sep(
                linewidth=1,
                padding=12,
                foreground=colors["grey"],
            ),
            widget.PulseVolume(
                channel="Master",
                fmt="󰕾 {}",
                foreground=colors["blue"],
                padding=10,
                fontsize=17,
            ),
            widget.Sep(
                linewidth=1,
                padding=12,
                foreground=colors["grey"],
            ),
            widget.Battery(
                format="󰁹 {percent:2.0%}",
                foreground=colors["green"],
                padding=10,
                low_percentage=0.2,
                fontsize=17,
            ),
            widget.Sep(
                linewidth=0,
                padding=16,
            ),
            # System Stats Group
            widget.CPU(
                format=" {load_percent:.0f}%",
                foreground=colors["yellow"],
                padding=10,
                update_interval=2,
                fontsize=16,
            ),
            widget.Sep(
                linewidth=1,
                padding=8,
                foreground=colors["grey"],
            ),
            widget.Memory(
                format=" {MemPercent:.0f}%",
                foreground=colors["magenta"],
                padding=10,
                update_interval=5,
                fontsize=16,
            ),
            widget.Sep(
                linewidth=1,
                padding=8,
                foreground=colors["grey"],
            ),
            widget.Net(
                format="↓{down:.0f}KB ↑{up:.0f}KB",
                foreground=colors["cyan"],
                padding=10,
                update_interval=3,
                fontsize=16,
            ),
            widget.Sep(
                linewidth=0,
                padding=16,
            ),
            # Systray & Power
            widget.Systray(
                icon_size=20,
                padding=6,
            ),
            widget.Sep(
                linewidth=0,
                padding=12,
            ),
            widget.TextBox(
                text=" ⏻ ",
                foreground=colors["fg"],
                background=colors["red"],
                padding=10,
                fontsize=18,
                mouse_callbacks={"Button1": lazy.spawn(powermenu)},
            ),
            widget.Spacer(length=10),
        ],
        size=38,
        margin=[8, 16, 4, 16],
        background=colors["bg_dark"],
        opacity=0.95,
    )


screens = [Screen(top=top_bar())]

# --------------------------------------------------------------
# Mouse
# --------------------------------------------------------------
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


# --------------------------------------------------------------
# Hooks
# --------------------------------------------------------------
@hook.subscribe.startup_once
def autostart():
    from subprocess import Popen
    from os.path import expanduser

    cmds = [
        "nm-applet",
        f"picom --config {expanduser('~')}/.config/picom/picom.conf",
        "blueman-applet",
        "flameshot",
        f"{expanduser('~')}/.fehbg",
    ]
    for c in cmds:
        try:
            Popen(c, shell=True)
        except Exception:
            pass


@hook.subscribe.client_new
def set_floating(window):
    wm_class = window.window.get_wm_class()
    if wm_class and any(c.lower() in ["pavucontrol", "feh"] for c in wm_class):
        window.floating = True


# --------------------------------------------------------------
# Misc Config
# --------------------------------------------------------------
dgroups_key_binder = None
dgroups_app_rules: List = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
reconfigure_screens = True
focus_on_window_activation = "smart"
wl_input_rules = None
wmname = "QtileTokyonightStorm"
