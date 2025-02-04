
export PATH=~/.nvm:/opt/homebrew/bin:/opt/homebrew/sbin:~/.dotfiles/bin:~/bin:$PATH # prefer rbenv versions
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export KUBE_EDITOR='code --wait'

if (( $+commands[go] ))
then
  export GOPATH="$(go env GOPATH)" # Go
fi

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
# source <(kubectl completion bash)

# if (( $+commands[jenv] ))
# then
#   eval "$(jenv init -)"
# fi

typeset -U PATH # Remove duplicates in $PATH

if (( $+commands[rbenv] ))
then
  eval "$(rbenv init - zsh)"
fi

