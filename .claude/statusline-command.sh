#!/bin/sh
# Claude Code status line — text-color-only aesthetic (no background colors)
input=$(cat)

# ── reset
reset="\033[0m"

# ── foreground colors
fg_periwinkle="\033[38;5;111m"  # model segment — xterm-256 #82a1f1
fg_green="\033[32m"             # context ok  (< 50 %)
fg_yellow="\033[33m"            # context warn (50–79 %)
fg_red="\033[31m"               # context crit (>= 80 %)
fg_grey="\033[38;5;245m"        # rate-limit base (dim grey)

# bold
bold="\033[1m"

# ── data
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# ── model segment — periwinkle bold text, terminal default bg
if [ -n "$model" ]; then
  printf "${fg_periwinkle}${bold} %s ${reset}" "$model"
fi

# ── context segment — color ramp as text color, bold
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  if [ "$used_int" -ge 80 ]; then
    printf "${fg_red}${bold} ctx:%s%% ${reset}" "$used_int"
  elif [ "$used_int" -ge 50 ]; then
    printf "${fg_yellow}${bold} ctx:%s%% ${reset}" "$used_int"
  else
    printf "${fg_green}${bold} ctx:%s%% ${reset}" "$used_int"
  fi
fi

# ── 5-hour rate-limit segment
if [ -n "$five" ]; then
  five_int=$(printf '%.0f' "$five")
  if [ "$five_int" -ge 80 ]; then
    printf "${fg_red}${bold} 5h:%s%% ${reset}" "$five_int"
  elif [ "$five_int" -ge 50 ]; then
    printf "${fg_yellow}${bold} 5h:%s%% ${reset}" "$five_int"
  else
    printf "${fg_grey} 5h:%s%% ${reset}" "$five_int"
  fi
fi

# ── 7-day rate-limit segment
if [ -n "$week" ]; then
  week_int=$(printf '%.0f' "$week")
  if [ "$week_int" -ge 80 ]; then
    printf "${fg_red}${bold} 7d:%s%% ${reset}" "$week_int"
  elif [ "$week_int" -ge 50 ]; then
    printf "${fg_yellow}${bold} 7d:%s%% ${reset}" "$week_int"
  else
    printf "${fg_grey} 7d:%s%% ${reset}" "$week_int"
  fi
fi

printf "%s" ""  # no trailing newline — Claude Code appends its own
