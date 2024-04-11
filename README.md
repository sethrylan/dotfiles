## OSX Setup

```shell
macos/install.sh
macos/defaults.sh
sudo softwareupdate -i -a
xcode-select --install
```

* Remap escape key

### Hostname

```shell
HOSTNAME=mynewname
sudo scutil --set HostName $HOSTNAME
sudo scutil --set LocalHostName $HOSTNAME
sudo scutil --set ComputerName $HOSTNAME
dscacheutil -flushcache
```

## Other tools

* Chrome Canary
* iStat Menus
* [Rectangle](https://rectangleapp.com/)


### iTerm2

Preferences ➔ Profiles ➔ Keys ➔ left option as Esc+, and then Profiles ➔ Keys ➔ Mappings to add option+left as Esc+b, and option+right as Esc+f

See https://stackoverflow.com/a/60079965



### Typora

* General -> On Launch -> Restore last closed
* Appearance -> Themes -> Use separate theme
* Image

![Image](./typora-image.png)


### Fonts
[JetBrains Mono](https://www.jetbrains.com/lp/mono/)

### VS Code

* Open the Command Palette (Cmd+Shift+P) and type 'shell command' to find the Shell Command: Install 'code' command in PATH command.


## Setup

### Git Prereqs

```shell
cat > ~/.gitconfig.local <<EOF
[user]
  name = <name>
  email = <email>
  signingkey = <from 1password>
[gpg]
  format = ssh
[gpg "ssh"]
  program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
EOF
```


## Install

### Clone

```shell
cd ~

git clone git@github.com:sethrylan/dotfiles.git ~/.dotfiles
```

### Set up dotfiles links

```shell
ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.zshenv ~/.zshenv
```

### Installs
```shell
sh macos/install.sh
sh homebrew/install.sh
sh node/install.sh
```


### Setup Ruby with rbenv

```shell
rbenv versions
..
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash
...
rbenv install 2.7.5
rbenv install 3.1.0
rbenv global 2.7.5
```

### Setup Java with jenv

```shell
jenv versions
...

...
jenv add /Library/Java/JavaVirtualMachines/jdk-11.0.12.jdk/Contents/Home
...
jenv global 11.0
```


### Sublime
* Install package control

```shell
ln -s ~/.dotfiles/sublime/User ~/Library/Application\ Support/Sublime\ Text/Packages/
```

## VS Code extensions

From https://wiki.nikitavoloboev.xyz/text-editors/vs-code/vs-code-extensions





