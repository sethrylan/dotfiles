#!/usr/bin/env zsh
# Install for codespaces

dir=$(dirname "$0")

ln -s ~/.dotfiles/gitconfig ~/.gitconfig

cat > ~/.zshenv <<EOF
source ~/.dotfiles/zsh/env.zsh
EOF

cat > ~/.zshrc <<EOF
source ~/.dotfiles/zsh/zshrc.zsh
EOF

git config --global commit.gpgsign true
git config --global merge.conflictStyle diff3
