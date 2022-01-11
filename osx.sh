#!/usr/bin/env bash

# close system preferences to keep it from overriding stuff
osascript -e 'tell application "System Preferences" to quit'

# translucent dock icons for hidden apps
defaults write com.apple.dock showhidden -bool true

# hide recent apps
defaults write com.apple.dock show-recents -bool false

# set the icon size of Dock items
defaults write com.apple.dock tilesize -int 50

# disable keyboard press and hold popup
defaults write -g ApplePressAndHoldEnabled -bool false

# set clock format and show secons
defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d  H:mm:ss'
defaults write com.apple.menuextra.clock ShowSeconds -bool true 

# disable 4 finger swipe gesture
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 0

# fast keyboard repeat rate
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# disable text correction
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false

# normal scroll direction
defaults write -g com.apple.swipescrolldirection -bool false

# expand print panel by default
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true

# expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

# show all file extensions
defaults write -g AppleShowAllExtensions -bool true

# disable warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# touch bar shows function keys (switch with `fullControlStrip`)
defaults write com.apple.touchbar.agent PresentationModeGlobal functionKeys
pkill "Touch Bar agent"; killall "ControlStrip";

# Third-party apps
##################

## Chrome
#########

defaults write com.google.Chrome DisablePrintPreview -bool true

## GPGTools
###########

# disable storing PGP passwords in macOS keychain
defaults write org.gpgtools.common DisableKeychain -bool yes


