#################################################################
########################### Functions ###########################
#################################################################

## Find and remove .DS_Store files
function dsdestroy
  find . -name ".DS_Store" -type f -print -ok rm -- '{}' \;
end

# watch & run js test file
function Wj
  # CMD+OPT+C is key bind to copy open file in VSCode
  osascript -e "tell application \"System Events\" to keystroke \"c\" using command down & option down"
  set f (pbpaste)
  cd (dirname "$f")
  watchexec -w run.js node run.js
end
