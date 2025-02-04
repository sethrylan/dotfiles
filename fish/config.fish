


###############################################################
######################### Environment #########################
###############################################################

export KUBE_EDITOR='code --wait'
export GOPATH="$(go env GOPATH)"
fish_add_path ~/.nvm
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path ~/.dotfiles/bin
fish_add_path ~/bin
fish_add_path $GOPATH


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

alias q='llm "Answer in as few words as possible. Use a brief style with short replies." -m gpt-4o-mini "$argv"'

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

