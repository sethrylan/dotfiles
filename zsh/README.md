## How to use


```shell
# first, install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cd ~
git clone ... .dotfiles

cat > ~/.zshenv <<EOF
source ~/.dotfiles/zsh/env.zsh
EOF


cat > ~/.zshrc <<EOF
source ~/.dotfiles/zsh/zshrc.zsh
EOF
```
