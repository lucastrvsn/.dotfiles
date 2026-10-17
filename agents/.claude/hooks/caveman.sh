#!/bin/sh
# UserPromptSubmit hook: keeps caveman mode alive per session by re-stating it every turn.

input=$(cat)
session=$(printf '%s' "$input" | jq -r '.session_id // empty')
prompt=$(printf '%s' "$input" | jq -r '.prompt // empty' | tr '[:upper:]' '[:lower:]')
[ -n "$session" ] || exit 0

dir="$HOME/.claude/caveman-state"
flag="$dir/$session"
mkdir -p "$dir"
find "$dir" -type f -mtime +7 -delete 2>/dev/null

case "$prompt" in
  *"stop caveman"* | *"normal mode"*)
    rm -f "$flag"
    ;;
  /caveman*)
    level=$(printf '%s' "${prompt#/caveman}" | awk '{print $1}')
    case "$level" in
      lite | full | ultra | wenyan-lite | wenyan-full | wenyan-ultra) ;;
      *) level=full ;;
    esac
    echo "$level" > "$flag"
    ;;
  *"caveman mode"* | *"talk like caveman"* | *"use caveman"*)
    [ -f "$flag" ] || echo full > "$flag"
    ;;
esac

[ -f "$flag" ] || exit 0
echo "Caveman mode active (level: $(cat "$flag")). Every chat reply in caveman style, including replies while running other skills. Quoted lines in skills give content, not wording. Files, code, commits, and PRs stay normal prose."
