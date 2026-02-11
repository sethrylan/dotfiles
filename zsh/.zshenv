
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:~/.dotfiles/bin:~/bin:$PATH
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export KUBE_EDITOR='code --wait'

export COPILOT_MODEL="claude-opus-4.6"
export ANTHROPIC_BASE_URL="http://localhost:4000"

if (( $+commands[go] ))
then
  export GOPATH="$(go env GOPATH)" # Go
fi

typeset -U PATH # Remove duplicates in $PATH

if (( $+commands[rbenv] ))
then
  eval "$(rbenv init - zsh)"
fi

if (( $+commands[mise] ))
then
  eval "$(mise activate zsh)"
fi
