if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

# Install xcode cli Tools
xcode-select --install

# echo "››› updating OS"
sudo softwareupdate -i -a

## VSCode settings
ln -sf "$DIR"/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
