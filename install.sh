#!/usr/bin/env zsh
# Install for codespaces

dir=$(dirname "$0")
DOTFILES=/workspaces/.codespaces/.persistedshare/dotfiles/

ln -s $DOTFILES/gitconfig ~/.gitconfig

cat > ~/.zshenv <<EOF
source $DOTFILES/zsh/env.zsh
EOF

cat > ~/.zshrc <<EOF
source $DOTFILES/zsh/zshrc.zsh
EOF

git config --global commit.gpgsign true
git config --global merge.conflictStyle diff3
git config --global gpg.program "/.codespaces/bin/gh-gpgsign"
