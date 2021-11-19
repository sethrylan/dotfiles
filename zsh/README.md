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




## .gitconfig

```
[core]
        trustctime = false
        ignorecase = false
[alias]
        s = status
        co = checkout
        ll = log --pretty=format:\"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn] %Cgreen%cr\" --decorate --numstat
        lnc = log --pretty=format:\"%h %s [%cn]\"
        lg = log --color --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset\" --abbrev-commit
        outgoing = log --graph --decorate origin/master..master
        incoming = log --graph --decorate master..origin/master
[pull]
        rebase = false
```




## Homebrew

```sh
brew install \
      tldr gist howdoi gotop tokei \
      gnuplot asciinema \
      watchexec reflex watch \
      octant aspell \
      jq dos2unix rbenv jenv wget wrk skaffold dive docker-ls telnet
```



## Other tools

* better touch tool
* istat menus
* flux