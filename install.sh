#!/usr/bin/env zsh

# Install for codespaces

dir=$(dirname "$0")
DOTFILES=/workspaces/.codespaces/.persistedshare/dotfiles

cp $DOTFILES/.gitconfig.codespaces ~

cat > ~/.zshenv <<EOF
source $DOTFILES/zsh/env.zsh
EOF

cat >> ~/.zshrc <<EOF
source $DOTFILES/zsh/zshrc.zsh
EOF

export KUBE_EDITOR='code --wait'
