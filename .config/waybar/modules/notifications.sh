#!/usr/bin/env bash
set -euo pipefail

ICON=""

previous_count=0

while true; do
    total=$(dunstctl count history)
    displayed=$(dunstctl count displayed)

    # Notificaciones nuevas (no leídas)
    unread=$(( total - displayed ))

    if [ "$unread" -gt 0 ]; then
        text="$ICON ($unread)"
        class="unread"
    else
        text="$ICON"
        class="none"
    fi

    printf '{"text": "%s", "class": "%s"}\n' "$text" "$class"

    previous_count=$unread
    sleep 1
done

