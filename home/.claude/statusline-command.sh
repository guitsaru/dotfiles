#!/usr/bin/env bash
# Claude Code status line — Gruvbox Dark theme, mirrors Starship config

# Gruvbox Dark palette (256-color approximations via true color)
fg0='\033[38;2;251;241;199m'      # #fbf1c7
bg1='\033[48;2;60;56;54m'         # #3c3836 (time bg)
bg_aqua='\033[48;2;104;157;106m'  # #689d6a (git bg)
fg_aqua='\033[38;2;104;157;106m'  # #689d6a
bg_blue='\033[48;2;69;133;136m'   # #458588 (model/context bg)
fg_blue='\033[38;2;69;133;136m'   # #458588
bg_orange='\033[48;2;214;93;14m'  # #d65d0e (user bg)
fg_orange='\033[38;2;214;93;14m'  # #d65d0e
bg_yellow='\033[48;2;215;153;33m' # #d79921 (dir bg)
fg_yellow='\033[38;2;215;153;33m' # #d79921
reset='\033[0m'

input=$(cat)

user=$(whoami)
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
[ -z "$dir" ] && dir=$(pwd)
# Truncate to last 3 path components
dir=$(echo "$dir" | awk -F/ '{
  n=NF; if(n>3){printf "…/"; for(i=n-2;i<=n;i++){printf $i; if(i<n)printf "/"}} else print $0
}')

model=$(echo "$input" | jq -r '.model.display_name // empty')
[ -z "$model" ] && model="Claude"

# Git branch (skip optional locks)
git_branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')" symbolic-ref --short HEAD 2>/dev/null)

# Context usage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

printf "${fg_orange}${reset}"
printf "${bg_orange}${fg0} %s ${reset}" "$user"
printf "${fg_orange}${fg_yellow}${reset}"
printf "${bg_yellow}${fg0} %s ${reset}" "$dir"

if [ -n "$git_branch" ]; then
  printf "${fg_yellow}${fg_aqua}${reset}"
  printf "${bg_aqua}${fg0}  %s ${reset}" "$git_branch"
  printf "${fg_aqua}${fg_blue}${reset}"
else
  printf "${fg_yellow}${fg_blue}${reset}"
fi

printf "${bg_blue}${fg0} %s ${reset}" "$model"

if [ -n "$used_pct" ]; then
  used_int=$(printf '%.0f' "$used_pct")
  printf "${fg_blue}${bg1}${reset}"
  printf "${bg1}${fg0}  ctx:%s%% ${reset}" "$used_int"
  printf "${fg_blue}${reset}"
else
  printf "${fg_blue}${reset}"
fi
