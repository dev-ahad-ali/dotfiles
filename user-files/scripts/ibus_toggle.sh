#!/bin/bash

# Toggle KDE Virtual Keyboard between IBus Wayland and None
# Equivalent to changing System Settings > Input Devices > Virtual Keyboard

CONFIG_FILE="$HOME/.config/kwinrc"

# Read current InputMethod setting
current_im=$(kreadconfig5 --file kwinrc --group Wayland --key InputMethod 2>/dev/null)

if [ "$current_im" = "/usr/share/applications/org.freedesktop.IBus.Panel.Wayland.Gtk3.desktop" ] || [ "$current_im" = "/usr/share/applications/ibus-wayland.desktop" ]; then
    # Currently IBus, switch to None
    kwriteconfig5 --file kwinrc --group Wayland --key InputMethod ""

    # Notify KWin about the config change
    busctl --user emit /kwinrc org.kde.kconfig.notify ConfigChanged "a{saay}" 1 Wayland 1 11 73 110 112 117 116 77 101 116 104 111 100 2>/dev/null

    notify-send "Virtual Keyboard" "Disabled IBus Wayland for Open Bangla Keyboard" -i input-keyboard-virtual-off
else
    # Currently None or something else, switch to IBus
    kwriteconfig5 --file kwinrc --group Wayland --key InputMethod "/usr/share/applications/org.freedesktop.IBus.Panel.Wayland.Gtk3.desktop"

    # Notify KWin about the config change
    busctl --user emit /kwinrc org.kde.kconfig.notify ConfigChanged "a{saay}" 1 Wayland 1 11 73 110 112 117 116 77 101 116 104 111 100 2>/dev/null

    notify-send "Virtual Keyboard" "Enabled IBus Wayland for Open Bangla Keyboard" -i input-keyboard
fi
