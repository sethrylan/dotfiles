## How to use



# Update Prefernces
* Reverse scroll
* Turn off smart quotes
* Remap escape key
* Key repeat


# Update Finder Prefernces
* Show extensions
* Hide drives


# Other tools
## iTerm2

Preferneces ➔ Profiles ➔ Keys ➔ left option as Esc+, and then Profiles ➔ Keys ➔ Mappings to add option+left as Esc+b, and option+right as Esc+f

See https://stackoverflow.com/a/60079965

## Better Touch Tool
## iStat Menus
## VS Code

# Setup

## Git Prereqs

```shell
ssh-keygen -t ed25519 -C “seth.rylan@gmail.com”

cat >  ~/.ssh/config <<EOF

Host *.github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
EOF

ssh-add -K ~/.ssh/id_ed25519

cat > ~/.gitconfig <<EOF
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
EOF
```

## Install


```shell
cd ~


git clone https://github.com/sethrylan/dotfiles ~/.dotfiles
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install \
      go \
      tldr gist howdoi gotop tokei \
      gnuplot asciinema screenfetch \
      watchexec reflex watch \
      octant aspell \
      jq dos2unix rbenv jenv wget wrk skaffold dive docker-ls telnet
```


## Set up dotfiles links


```shell
ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application Support/Code/User/settings.json

cat > ~/.zshenv <<EOF
source ~/.dotfiles/zsh/env.zsh
EOF


cat > ~/.zshrc <<EOF
source ~/.dotfiles/zsh/zshrc.zsh
EOF
```



## VS Code extensions

From https://wiki.nikitavoloboev.xyz/text-editors/vs-code/vs-code-extensions



