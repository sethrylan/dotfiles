#!/usr/bin/env zsh

# Install for codespaces

dir=$(dirname "$0")
DOTFILES=/workspaces/.codespaces/.persistedshare/dotfiles

git config --global core.trustctime false
git config --global core.ignorecase false
git config --global alias.s status
git config --global alias.co checkout
git config --global alias.lol 'log --graph --oneline --decorate'
git config --global alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn] %Cgreen%cr" --decorate --numstat'
git config --global alias.lnc 'log --pretty=format:"%h %s [%cn]"'
git config --global alias.lg 'log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset" --abbrev-commit'
git config --global pull.rebase false
git config --global checkout.workers  0
git config --global commit.gpgsign true
git config --global merge.conflictStyle diff3
git config --global gpg.program "/.codespaces/bin/gh-gpgsign"
git config --global push.autoSetupRemote true


cat > ~/.zshenv <<EOF
source $DOTFILES/zsh/env.zsh
EOF

cat >> ~/.zshrc <<EOF
source $DOTFILES/zsh/zshrc.zsh
EOF

export KUBE_EDITOR='code --wait'
