#!/bin/bash

windows_json=$(niri msg --json list-windows)
active_ws=$(niri msg --json get-workspaces | jq -r '.[] | select(.active == true).id')

# Функция для выбора иконки по app_id
get_icon() {
  case "$1" in
    firefox) echo "󰈹" ;;        # Firefox
    code) echo "󰨞" ;;           # VS Code
    foot) echo "" ;;           # Terminal
    thunar) echo "" ;;         # File Manager
    obsidian) echo "󰈙" ;;       # Obsidian
    steam) echo "󰓓" ;;          # Steam
    *) echo "󰋩" ;;              # generic icon
  esac
}

# Собираем иконки для активного workspace
icons=$(echo "$windows_json" | jq -r --arg ws "$active_ws" '
  [.[] | select(.workspace == ($ws | tonumber)) | {app_id: .app_id, focused: .focused}] |
  map(@base64)
' | while read -r encoded; do
  obj=$(echo "$encoded" | base64 --decode)
  app_id=$(echo "$obj" | jq -r '.app_id // "unknown"')
  focused=$(echo "$obj" | jq -r '.focused')
  icon=$(get_icon "$app_id")

  if [ "$focused" = "true" ]; then
    echo "<span class=\"active-window\">$icon</span>"
  else
    echo "$icon"
  fi
done | tr '\n' ' ')

echo "{\"text\": \"$icons\"}"
