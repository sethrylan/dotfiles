
export PATH=$PATH:~/.jenv/bin:~/.jenv/shims
export PATH=$PATH:~/google-cloud-sdk/bin
export PATH=$PATH:~/.rbenv/shims
export PATH=$PATH:~/.nvm:~/.nvm/versions/node/v10.16.0/bin
export PATH=$PATH:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Library/Apple/usr/bin
export PATH=$PATH:/opt/homebrew/bin:/opt/homebrew/sbin

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export GOOGLE_APPLICATION_CREDENTIALS=~/.cloud-builder-key.json

# export GOPATH="$(go env GOPATH)" # Go

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
# source <(kubectl completion bash)

if which jenv > /dev/null; then eval "$(jenv init -)"; fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

typeset -U PATH # Remove duplicates in $PATH
