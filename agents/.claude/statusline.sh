#!/bin/bash
# Read JSON data that Claude Code sends to stdin
# Remember to install jq to extract data from json string, makes it easier
# You can piple json in text format to test the script
input=$(cat)

# Set color variables. Escape sequences can vary by system, bash, zsh, etc.
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[91m'
RESET=$'\033[0m'

# Extract fields using jq. Remember to install jq
# Get Model Name
MODEL=$(echo "$input" | jq -r '.model.display_name')
# Get Used Percentage, Total Outout Tokens and Total Input Tokens, save to variables
# The "// 0" provides a fallback if the field is null
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
OTOK=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0' | cut -d. -f1)
ITOK=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0' | cut -d. -f1)

# Context progress bar, yey
BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && BAR=$(printf "%${FILLED}s" | tr ' ' '▓')
[ "$EMPTY" -gt 0 ] && BAR="${BAR}$(printf "%${EMPTY}s" | tr ' ' '░')"

# Pick bar color based on usage. < 50 green, < 80 yello, otherwise red
if [ "$PCT" -lt 50 ]; then
    BAR_COLOR="$GREEN"
elif [ "$PCT" -lt 80 ]; then
    BAR_COLOR="$YELLOW"
else
    BAR_COLOR="$RED"  # bright red
fi

# Git status for folder, if available
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')

    GIT_STATUS=""
    [ "$STAGED" -gt 0 ] && GIT_STATUS="${GREEN}+${STAGED}${RESET}"
    [ "$MODIFIED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}${YELLOW}~${MODIFIED}${RESET}"

    # Show statusline with git status if available
    echo -e "$MODEL | i$ITOK, o$OTOK | cntxt ${BAR_COLOR}$BAR${RESET} ${PCT}% | ⎇ $BRANCH $GIT_STATUS"
else
    # Else show statusline without git status
    echo -e "$MODEL | i$ITOK, o$OTOK | cntxt ${BAR_COLOR}$BAR${RESET} ${PCT}%"
fi
