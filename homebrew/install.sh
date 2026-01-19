#!/bin/sh

if test ! $(which brew)
then
  echo "  Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi
fi

# Run Homebrew through the Brewfile
echo "› brew bundle"


brew install "fish"
brew install "watch"
brew install "ripgrep"
brew install "1password-cli"
brew install "ack"
brew install "mise"
brew install "readline"
brew install "gpg"
brew install "pinentry-mac"
brew install "go"
brew install "tldr"          # tldr-pages
brew install "grc"           # colorize log files
brew install "gh"            # github cli
brew install "howdoi"        # `howdoi print stack trace python
brew install "gotop"         # https://github.com/xxxserxxx/gotop/wiki/Micro-Blog
brew install "tokei"         # code statistics
brew install "gnuplot"       # http://www.gnuplot.info/
brew install "asciinema"     # `asciinema rec`
brew install "watchexec"     # `watchexec -e js,css,html npm run build`
brew install "octant"        # k8s dashboard
brew install "aspell"        # spell checker
brew install "jq"
brew install "dos2unix"
brew install "wget"
brew install "wrk"           # http benchmarking
brew install "skaffold"
brew install "dive"
brew install "docker-ls"     # docker registry inspector
brew install "telnet"
brew install "tree"
brew install "git"           # get the latest git
brew install git-lfs
brew install "azure-cli"
brew install "llm"
