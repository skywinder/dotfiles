#Collection of macOS modifications:

# Show hidden files:
defaults write com.apple.finder AppleShowAllFiles YES

# Dock to the right:
defaults write com.apple.Dock orientation -string right

# don't show instantly dock
# https://www.quora.com/How-can-I-completely-hide-or-remove-the-Dock-in-Mac-OS-X-Yosemite
defaults write com.apple.Dock autohide-delay -float 5 && killall Dock

# make Dock super small:
# defaults read com.apple.dock tilesize -> 64
defaults write com.apple.dock tilesize -int 1 && killall Dock

######
###### additional cli instalations goes there
######

# Install all from https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package quicklookase qlvideo

#### https://github.com/tborychowski/slack-nord-theme
### - run install.sh to make slack dark



##########

# Firefox:
#(6) Set Firefox to look for userChrome.css at startup (updated 5/24/2019)

#To make startup faster for most users, Firefox 69 will no longer look for this file automatically. You need to tell it to look. Here's how:

    #In a new tab, type or paste about:config in the address bar and press Enter/Return. Click the button accepting the risk.
    #In the search box above the list, type or paste userprof and pause while the list is filtered. If you do not see anything on the list, please ignore the rest of these instructions. You can close this tab now.
    #Double-click the toolkit.legacyUserProfileCustomizations.stylesheets preference to switch the value from false to true.

# add userChrome.css
#Go to profiles folder in firefox, then 
# >    mkdir chrome
# >    ln -s ~/dotfiles/userChrome.css ./chrome/userChrome.css

# TODO:

# Add fingerpring as sudo: https://www.imore.com/how-use-sudo-your-mac-touch-id 

# iTerm: Preferences > Keys > Show/hide all windows with a system-wide hotkey - set F12 + set natural presets in profile: https://apple.stackexchange.com/a/293988/49492
