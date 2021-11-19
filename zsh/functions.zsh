
# go to directory of file in clipboard
W() {
    # CMD+OPT+C is key bind to copy open file in VSCode
    osascript -e "tell application \"System Events\" to keystroke \"c\" using command down & option down"
    f=$(pbpaste)
    cd "$(dirname "$f")"
}


# watch & run js test file
Wj() {
    # CMD+OPT+C is key bind to copy open file in VSCode
    osascript -e "tell application \"System Events\" to keystroke \"c\" using command down & option down"
    f=$(pbpaste)
    cd "$(dirname "$f")"
    watchexec -w run.js node run.js
}

# git clone and cd instantly to cloned repo. gcd <git-url>
gcd() {
   git clone "$(pbpaste)" && cd "${1##*/}"
}


# ram <process-name> - Find how much RAM a process is taking.
ram() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}
