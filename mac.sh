#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

################
# General
################

# Scrollbars visible when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Maximize windows on double clicking them:
defaults write -g AppleActionOnDoubleClick 'Maximize'

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

################
# Finder
################

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Hide status bar
defaults write com.apple.finder ShowStatusBar -bool false

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

################
# Dock
################

# Show indicator lights for open apps in Dock
defaults write com.apple.dock show-process-indicators -bool true

# Show the task switcher on all available displays
defaults write com.apple.Dock appswitcher-all-displays -bool true

# Set the icon size of Dock items to 48 pixels
defaults write com.apple.dock tilesize -int 48

# Set the magnification level when hover
defaults write com.apple.dock largesize -int 64

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Enable Space switching on Command-Tab
defaults write com.apple.dock workspaces-auto-swoosh -bool true

# Show Dock instantly
defaults write com.apple.dock autohide-delay -float 0

# Disable the Recents Apps
defaults write com.apple.dock show-recents -bool false

echo 'Restarting apps...'
killall Finder
killall Dock
echo "Done. Note that some of the changes require a logout/restart to take effect."

