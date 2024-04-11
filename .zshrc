#!/usr/bin/env zsh

plugins=(git fzf)
ZSH_THEME="robbyrussell"
[ -s "$HOME/.oh-my-zsh/oh-my-zsh.sh" ] && source $HOME/.oh-my-zsh/oh-my-zsh.sh # This loads oh-my-zsh

###############################################################
########################### Aliases ###########################
###############################################################
alias kus='docker run --rm -i --volume "$(pwd):/workdir" --workdir /workdir k8s.gcr.io/kustomize/kustomize:v4.5.5'
alias k9s='docker run --rm -it -v ~/.kube/config:/root/.kube/config quay.io/derailed/k9s:latest'

alias gistit='pbpaste | gh gist create - | xargs open'
alias top='gotop'
alias how='howdoi'
alias cleandsstore="find . -type f -name '*.DS_Store' -ls -delete" # Recursively delete `.DS_Store` files
alias rec='docker run --rm -ti -v "$HOME/.config/asciinema":/root/.config/asciinema asciinema/asciinema'

alias g='git'
alias gnvm="git reset --soft HEAD~1"  # undo commit https://twitter.com/bencodezen/status/1371564043278946305
alias gfsk='git fetch && git reset --hard && git clean -dfx' # Reset repo to clean remote state
alias greset='git reset --soft HEAD^' # Undo last commit, but don't throw away your changes

alias k='kubectl'
alias sb='open -a /Applications/Sublime\ Text.app/'

alias dstop='docker stop $(docker ps -a -q)' # Stop running containers
alias dremove='docker rm -f $(docker ps -q)' # Stop & remove running containers

alias ls='ls -G'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias vi=vim

alias ports='netstat -tulanp'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

###############################################################
########################### Options ###########################
###############################################################
HISTSIZE=100000                   # big big history
HISTFILESIZE=100000               # big big history
SAVEHIST=100000                   # Number of history entries to save to disk
HISTFILE=~/.zsh_history
HISTDUP=erase                     # Erase duplicates in the history file
HIST_STAMPS="yyyy-mm-dd"

setopt hist_ignore_space          # Do not record an event starting with a space.
setopt hist_ignore_dups           # Ignore duplicates
setopt append_history             # Append history to the history file (no overwriting)
setopt share_history              # Share history across terminals
setopt inc_append_history         # Immediately append to the history file, not just when a term is killed
setopt extended_glob              # Use extended globbing syntax
setopt auto_cd                    # Auto change to a dir without typing cd


#################################################################
########################### Functions ###########################
#################################################################

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
