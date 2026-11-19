#!/bin/sh
# macOS system settings. Safe to run again at any time.
set -e

# --- keyboard ---
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Spotlight shortcut: option+space instead of cmd+space
# (hotkey 64; parameters = ascii code, key code 49 = space, modifier 524288 = option)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 \
    "<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>524288</integer></array></dict></dict>"
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u 2>/dev/null || true

# --- mouse / trackpad (speeds: System Settings > Mouse / Trackpad) ---
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2
defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 1
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 0.875
defaults write NSGlobalDomain com.apple.trackpad.scrolling -float 0.1838
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false

# --- appearance ---
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

# --- dock ---
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock largesize -int 16
defaults write com.apple.dock persistent-apps -array   # empty dock
# hot corners: 1=none 2=mission control 4=desktop 5=screensaver 10=sleep display 13=lock
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-br-corner -int 1

# --- window manager ---
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

# --- finder ---
defaults write com.apple.finder FXPreferredViewStyle -string icnv   # icon view
defaults write com.apple.finder FXDefaultSearchScope -string SCcf  # search current folder
defaults write com.apple.finder NewWindowTarget -string PfHm       # new window opens home

# --- power ---
sudo pmset -a displaysleep 0   # screen never sleeps

# --- menu bar ---
defaults write com.apple.menuextra.clock ShowSeconds -bool true
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true
defaults -currentHost write com.apple.controlcenter Bluetooth -int 18   # 18 = always show, 24 = hide
# Hearing item, which holds Background Sounds
defaults -currentHost write com.apple.controlcenter Hearing -int 18
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Hearing" -bool true

# --- login items ---
login_items=$(osascript -e 'tell application "System Events" to get the name of every login item')
for app in Rectangle Syncthing; do
    case "$login_items" in
        *"$app"*) ;;
        *) osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"/Applications/$app.app\", hidden:false}" > /dev/null ;;
    esac
done

# --- wallpaper (all screens) ---
wallpaper="$(cd "$(dirname "$0")" && pwd)/wallpaper.jpeg"
osascript -e "tell application \"System Events\" to set picture of every desktop to \"$wallpaper\""

# --- app preferences exported into bootstrap/prefs ---
dir="$(dirname "$0")/prefs"
for plist in "$dir"/*.plist; do
    [ -e "$plist" ] || continue
    defaults import "$(basename "$plist" .plist)" "$plist"
done

killall Dock Finder SystemUIServer ControlCenter 2>/dev/null || true
echo "macOS settings applied. Log out and in for keyboard and mouse changes."
