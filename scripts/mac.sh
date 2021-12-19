#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

################
# general
################

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

################
# mouse, keyboard
################

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

################
# finder
################

# show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# hide status bar
defaults write com.apple.finder ShowStatusBar -bool false

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

################
# dock
################

# show the task switcher on all available displays
defaults write com.apple.Dock appswitcher-all-displays -bool true

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Enable Space switching on Command-Tab
defaults write com.apple.dock workspaces-auto-swoosh -bool true

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 10
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Show applications windows
defaults write com.apple.dock wvous-bl-corner -int 3
defaults write com.apple.dock wvous-bl-modifier -int 0

################
# terminal
################

# use utf-8
defaults write com.apple.terminal StringEncodings -array 4

################
# activity monitor
################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

################
# app store
################

# enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

################
# battery
################

# computer sleep: 10 min
sudo pmset -b sleep 10

# display sleep: 5 min
sudo pmset -b displaysleep 5

# put the hard disk(s) to sleep when possible: 10 min
sudo pmset -b disksleep 10

# slightly dim the display when using this power source
sudo pmset -b lessbright 1

# automatically reduce brightness before display goes to sleep
sudo pmset -b halfdim 1

# restart automatically if the computer freezes
sudo pmset -b panicrestart 15

################
# power adapter
################

# computer sleep: 30 min
sudo pmset -c sleep 30

# display sleep: 10 min
sudo mset -c displaysleep 10

# put the hard disk(s) to sleep when possible: 10 min
sudo pmset -c disksleep 10

# wake for network access
sudo pmset -c womp 0

# automatically reduce brightness before display goes to sleep
sudo pmset -c halfdim 1

# start up automatically after a power failure
sudo pmset -c autorestart 1

# restart automatically if the computer freezes
sudo pmset -c panicrestart 15

echo "Done. Note that some of these changes require a logout/restart to take effect."

