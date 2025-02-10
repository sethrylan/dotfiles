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

### Fonts

[Mono Sans](https://github.com/mona-sans)

### VS Code

* Open the Command Palette (Cmd+Shift+P) and type 'shell command' to find the Shell Command: Install 'code' command in PATH command.

## VS Code extensions

- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [GitLens](https://arc.net/l/quote/hmjppduv)
- [GitHub Theme](https://marketplace.visualstudio.com/items?itemName=GitHub.github-vscode-theme)
- [Markdown Preview Mermaid Support](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid)
- [shellcheck](https://github.com/vscode-shellcheck/vscode-shellcheck)
- [VSCode Essentials](https://marketplace.visualstudio.com/items?itemName=jabacchetta.vscode-essentials)
- [GitHub](https://marketplace.visualstudio.com/items?itemName=KnisterPeter.vscode-github)
- [Markdown Preview GitHub Styling](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-preview-github-styles)


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
bash ./install
```

```shell
ln ./vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```

### Installs

```shell
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

```shell
jenv add /Library/Java/JavaVirtualMachines/jdk-11.0.12.jdk/Contents/Home
...
jenv global 11.0
```

### Raycast

- [Oblique Strategies](https://github.com/raycast/extensions/blob/be2ed8cc32c1a225ea8b3bde9bf708e8d9971b54/extensions/oblique-strategies/README.md)
