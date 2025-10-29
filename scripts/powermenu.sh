#!/usr/bin/env bash

# Modern Rofi Power Menu with Tokyo Night Storm Theme
# Provides options to lock, logout, reboot, shutdown, and suspend

# Tokyo Night Storm colors
BG="#24283b"
BG_DARK="#1f2335"
BG_HIGHLIGHT="#2d3348"
FG="#c0caf5"
CYAN="#7dcfff"
BLUE="#7aa2f7"
RED="#f7768e"
YELLOW="#e0af68"
GREEN="#9ece6a"

# Modern Rofi theme with rounded corners and better spacing
ROFI_OPTS=(
    -theme-str "* { background-color: transparent; text-color: ${FG}; }"
    -theme-str "window { 
        transparency: \"real\";
        background-color: ${BG}ee;
        border: 3px;
        border-color: ${CYAN};
        border-radius: 16px;
        width: 450px;
        padding: 20px;
        location: center;
        anchor: center;
    }"
    -theme-str "mainbox { 
        background-color: transparent;
        spacing: 20px;
        children: [message, listview];
    }"
    -theme-str "message {
        background-color: transparent;
        border: 0;
        padding: 10px;
    }"
    -theme-str "textbox {
        background-color: ${BG_DARK};
        text-color: ${CYAN};
        padding: 15px;
        border-radius: 10px;
        horizontal-align: 0.5;
        vertical-align: 0.5;
    }"
    -theme-str "listview { 
        background-color: transparent;
        spacing: 8px;
        lines: 5;
        columns: 1;
        fixed-height: true;
        border: 0;
    }"
    -theme-str "element {
        background-color: ${BG_DARK};
        text-color: ${FG};
        padding: 15px 20px;
        border-radius: 10px;
        spacing: 10px;
    }"
    -theme-str "element selected {
        background-color: ${CYAN};
        text-color: ${BG};
    }"
    -theme-str "element-text {
        background-color: transparent;
        text-color: inherit;
        vertical-align: 0.5;
    }"
)

# Power menu options with icons
LOCK="🔒  Lock Screen"
LOGOUT="🚪  Logout"
REBOOT="🔄  Reboot"
SHUTDOWN="⏻  Shutdown"
SUSPEND="💤  Suspend"

# Display menu and capture selection
SELECTED=$(printf "${LOCK}\n${LOGOUT}\n${REBOOT}\n${SHUTDOWN}\n${SUSPEND}\n" | \
    rofi -dmenu \
    -i \
    -mesg "Choose your power option" \
    -font "JetBrainsMono Nerd Font Propo 16" \
    -theme-str "inputbar { enabled: false; }" \
    "${ROFI_OPTS[@]}")

# Execute selected option
case $SELECTED in
    $LOCK)
        # Lock screen with blurred wallpaper
        ~/dotfiles/scripts/lock.sh
        ;;
    $LOGOUT)
        # Qtile logout
        qtile cmd-obj -o cmd -f shutdown
        ;;
    $REBOOT)
        # Confirm before rebooting
        CONFIRM=$(printf "Yes\nNo\n" | rofi -dmenu \
            -i \
            -mesg "Are you sure you want to reboot?" \
            -font "JetBrainsMono Nerd Font Propo 16" \
            -theme-str "inputbar { enabled: false; }" \
            -theme-str "window { width: 350px; border-radius: 16px; padding: 20px; background-color: ${BG}ee; border: 3px; border-color: ${YELLOW}; }" \
            -theme-str "listview { lines: 2; spacing: 8px; }" \
            -theme-str "element { padding: 12px; border-radius: 8px; background-color: ${BG_DARK}; }" \
            -theme-str "element selected { background-color: ${YELLOW}; text-color: ${BG}; }" \
            -theme-str "message { padding: 10px; }" \
            -theme-str "textbox { padding: 10px; background-color: ${BG_DARK}; border-radius: 8px; text-color: ${YELLOW}; }")
        if [[ $CONFIRM == "Yes" ]]; then
            systemctl reboot
        fi
        ;;
    $SHUTDOWN)
        # Confirm before shutdown
        CONFIRM=$(printf "Yes\nNo\n" | rofi -dmenu \
            -i \
            -mesg "Are you sure you want to shutdown?" \
            -font "JetBrainsMono Nerd Font Propo 16" \
            -theme-str "inputbar { enabled: false; }" \
            -theme-str "window { width: 350px; border-radius: 16px; padding: 20px; background-color: ${BG}ee; border: 3px; border-color: ${RED}; }" \
            -theme-str "listview { lines: 2; spacing: 8px; }" \
            -theme-str "element { padding: 12px; border-radius: 8px; background-color: ${BG_DARK}; }" \
            -theme-str "element selected { background-color: ${RED}; text-color: ${BG}; }" \
            -theme-str "message { padding: 10px; }" \
            -theme-str "textbox { padding: 10px; background-color: ${BG_DARK}; border-radius: 8px; text-color: ${RED}; }")
        if [[ $CONFIRM == "Yes" ]]; then
            systemctl poweroff
        fi
        ;;
    $SUSPEND)
        systemctl suspend
        ;;
esac
