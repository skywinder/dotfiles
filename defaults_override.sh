#Collection of macOS modifications:

# Show hidden files:
defaults write com.apple.finder AppleShowAllFiles YES

# Dock to the right:
defaults write com.apple.Dock orientation -string right

# don't show instantly dock
# https://www.quora.com/How-can-I-completely-hide-or-remove-the-Dock-in-Mac-OS-X-Yosemite
defaults write com.apple.Dock autohide-delay -float 5 && killall Dock

