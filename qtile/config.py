from typing import List

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
    fontsize=19,
    padding=6,
    foreground=colors["fg"],
)
extension_defaults = widget_defaults.copy()


def top_bar():
    return bar.Bar(
        [
            widget.GroupBox(
                highlight_method="block",
                active=colors["fg"],
                inactive=inactive,
                this_current_screen_border=accent,
                this_screen_border=colors["grey"],
                other_current_screen_border=colors["grey"],
                other_screen_border=colors["grey"],
                urgent_border=colors["red"],
                padding=6,
                rounded=False,
                hide_unused=True,
                borderwidth=2,
                disable_drag=True,
                fontsize=19,
            ),
            widget.CurrentLayout(mode="icon", padding=6, foreground=accent),
            widget.TextBox(text="|", foreground=colors["grey"], padding=6),
            widget.WindowName(
                format="{name}",
                max_chars=60,
                empty_group_string="",
                foreground=colors["cyan"],
                padding=0,
                fontsize=19,
            ),
            widget.Spacer(),
            widget.Clock(
                format="%Y-%m-%d  %H:%M",
                foreground=colors["magenta"],
                padding=8,
                fontsize=19,
            ),
            widget.Spacer(),
            widget.Backlight(
                backlight_name="auto",
                fmt="  {}",
                foreground=colors["yellow"],
                padding=6,
                fontsize=19,
            ),
            widget.TextBox(text="|", foreground=colors["grey"], padding=6),
            widget.PulseVolume(
                channel="Master",
                fmt="  {}",
                foreground=colors["fg"],
                padding=6,
                fontsize=19,
            ),
            widget.TextBox(text="|", foreground=colors["grey"], padding=6),
            widget.Battery(
                format="{percent:2.0%}",
                foreground=colors["fg"],
                padding=6,
                low_percentage=0.2,
                fontsize=19,
            ),
            widget.TextBox(text="|", foreground=colors["grey"], padding=6),
            # Status widgets (right)
            widget.CPU(
                format="CPU {load_percent:.0f}%",
                foreground=colors["yellow"],
                padding=6,
                update_interval=2,
                fontsize=19,
            ),
            widget.Memory(
                format="RAM {MemPercent:2.0f}%",
                foreground=colors["magenta"],
                padding=6,
                update_interval=5,
                fontsize=19,
            ),
            widget.Net(
                format="Net ↓{down:.1f}KB ↑{up:.1f}KB",
                foreground=colors["green"],
                padding=6,
                update_interval=3,
                fontsize=19,
            ),
            widget.TextBox(text="|", foreground=colors["grey"], padding=6),
            widget.Systray(icon_size=20, padding=6),
            widget.TextBox(
                text="",
                foreground=colors["red"],
                padding=8,
                fontsize=19,
                mouse_callbacks={"Button1": lazy.spawn(launcher)},
            ),
        ],
        size=30,
        margin=[4, 8, 2, 8],
        background=colors["bg_dark"],
        opacity=1.0,
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

    cmds = [
        "nm-applet",
        "picom --experimental-backends",
        "blueman-applet",
        "flameshot",
        "feh --bg-scale ~/Pictures/desktop-wallpaper-omega-squad-teemo.jpg",
    ]
    for c in cmds:
        try:
            Popen(c.split())
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
