#!/usr/bin/env bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Output pretty text banner
banner() {
  echo -e "\n\n\033[0;34m"
  printf "%0.s#" {1..80}
  echo -e "\n# ${1}"
  printf "%0.s#" {1..80}
  echo -e "$(tput sgr0)\n"
  return
}

################################################################################
# Homebrew
################################################################################

# Install Homebrew
if test ! $(which brew); then
  banner "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

banner "Updating Homebrew"
brew update
brew analytics off

banner "Tapping Additional Homebrew Repos"
brew tap caskroom/cask
brew tap caskroom/fonts

banner "Installing Homebrew Packages"
brew install git
brew install node --with-full-icu
brew install openssh
brew install python
brew install tig
brew install vim --with-override-system-vi
brew install wget --with-iri
brew install yarn
brew install zsh

# Homebrew Casks
banner "Installing Homebrew Casks"
brew cask install alfred
brew cask install atom
brew cask install ccleaner
brew cask install firefox
brew cask install font-fira-code
brew cask install google-chrome
brew cask install postman
brew cask install spectacle
brew cask install spotify
brew cask install the-unarchiver
brew cask install vlc

################################################################################
# Yarn
################################################################################

yarn config set prefix ~/.yarn

banner "Installing Yarn Packages"
yarn global add nodemon
yarn global add pm2
yarn global add svgo

################################################################################
# Update and Cleanup
################################################################################

banner "Update and Cleanup"

# homebrew
brew update
brew upgrade
brew cleanup
brew cask cleanup
brew prune
brew doctor

# npm/yarn
npm install -g npm
npm update -g
yarn global upgrade

################################################################################
# General UI/UX
################################################################################

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "fr"
defaults write NSGlobalDomain AppleLocale -string "fr_FR@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/Paris" > /dev/null

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

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
# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Disable the all too sensitive backswipe on trackpads
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

for app in "Activity Monitor" \
	"cfprefsd" \
	"Dock" \
	"Finder" \
	"Google Chrome" \
	"SystemUIServer" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done

banner "Done. Note that some of these changes require a logout/restart to take effect."
