
alias gistit='gist -Pcp -f output | xargs open'


alias g='git'
alias k='kubectl'
alias ls='ls -G'
alias sb='open -a /Applications/Sublime\ Text.app/'

## Use a long listing format ##

alias ll='ls -la'

## Show hidden files ##
alias l.='ls -d .* --color=auto'


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
alias svi='sudo vi'


alias ports='netstat -tulanp'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'


## get top process eating cpu ##

alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

alias ready-check='docker pull dtr.mapsandbox.net/ckm/ready-check:latest &> /dev/null && docker run --rm -v ~/.m2:/root/.m2 -v `pwd`:/repo dtr.mapsandbox.net/ckm/ready-check'
