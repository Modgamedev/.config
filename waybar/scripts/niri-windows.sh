#!/usr/bin/env bash
set -euo pipefail

WORKSPACES_JSON=$(niri msg --json workspaces 2>/dev/null || echo "[]")
WINDOWS_JSON=$(niri msg --json windows 2>/dev/null || echo "[]")

REAL_ID=$(echo "$WORKSPACES_JSON" | jq -r '.[] | select(.is_active == true) | .id // empty')
ACTIVE_WINDOW_ID=$(echo "$WINDOWS_JSON" | jq -r '.[] | select(.is_focused == true) | .id // empty')

if [[ -z "$REAL_ID" ]]; then
  jq -c -n '{"text":"—","class":"active-windows"}'
  exit 0
fi

TEXT=$(echo "$WINDOWS_JSON" | jq -r --arg ws_id "$REAL_ID" --arg active_id "$ACTIVE_WINDOW_ID" '
  [.[] 
    | select(.workspace_id == ($ws_id | tonumber))
    | {
        pos: (.layout.pos_in_scrolling_layout[0] // 9999),
        id: (.id | tostring),
        icon: (
          if .app_id == "firefox" then ""
          elif .app_id == "foot" then ""
          elif .app_id == "code" or .app_id == "vscode" then "🧑‍💻"
          elif .app_id == "mpv" then "🎬"
          elif .app_id == "thunar" then ""
          else "📄" end
        )
      }
    | . + {display: (if .id == $active_id then "<span foreground=\"yellow\">\(.icon)</span>" else .icon end)}
  ]
  | sort_by(.pos)
  | map(.display)
  | join("  ")
')

jq -c -n --arg text "$TEXT" '{"text": $text, "class": "active-windows"}'
