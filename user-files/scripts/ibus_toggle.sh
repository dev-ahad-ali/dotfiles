#!/bin/bash

# Read current InputMethod setting
CURRENT_IM=$(kreadconfig6 --file kwinrc --group Wayland --key InputMethod 2>/dev/null)
IBUS_PATH="/usr/share/applications/org.freedesktop.IBus.Panel.Wayland.Gtk3.desktop"

# Toggle the target value
if [ "$CURRENT_IM" = "$IBUS_PATH" ] || [ "$CURRENT_IM" = "/usr/share/applications/ibus-wayland.desktop" ]; then
  NEW_IM=""
else
  NEW_IM="$IBUS_PATH"
fi

# Write the new configuration
kwriteconfig6 --file kwinrc --group Wayland --key InputMethod "$NEW_IM"

# Notify KWin about the config change (only needed once here)
busctl --user emit /kwinrc org.kde.kconfig.notify ConfigChanged "a{saay}" 1 Wayland 1 11 73 110 112 117 116 77 101 116 104 111 100 2>/dev/null
