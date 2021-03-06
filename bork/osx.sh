# set computer name
ComputerName=$(scutil --get ComputerName)
UserLongName=$(osascript -e "long user name of (system info)")
if [[ $ComputerName =~ $UserLongName ]]; then
  echo "Please supply a name for this computer:"
  read name
  echo "Administrative privileges are necessary for this rename."
  sudo -v
  sudo scutil --set ComputerName $name
  sudo scutil --set HostName $name
  sudo scutil --set LocalHostName $name
  if [ "$?" -eq "0" ]; then
    echo "ok: HostName set to $name"
  else
    echo "* failure to set HostName"
  fi
else
  echo "ok: ComputerName already set"
fi

# get dockutil
ok brew dockutil
if did_install; then
  echo "Removing all entries from the dock"
  dockutil --remove all
fi

# default to save to disk, not iCloud
ok defaults NSGlobalDomain NSDocumentSaveNewDocumentsToCloud bool false

# don't prompt time machine on new disks
ok defaults com.apple.TimeMachine DoNotOfferNewDisksForBackup bool true

# dock
ok defaults com.apple.dock autohide bool true
ok defaults com.apple.dock static-only bool true
ok defaults com.apple.dock workspaces-swoosh-animation-off bool true
ok defaults com.apple.dock tilesize integer 36

# go away dashboard
ok defaults com.apple.dashboard mcx-disabled bool true
ok defaults com.apple.dock dashboard-in-overlay bool true

# don't re-order spaces in mission control
ok defaults com.apple.dock mru-spaces bool false

# require password immediately on sleep or screensaver
ok defaults com.apple.screensaver askForPassword bool true
ok defaults com.apple.screensaver askForPasswordDelay integer 0

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
ok defaults NSGlobalDomain AppleKeyboardUIMode integer 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
ok defaults com.apple.universalaccess closeViewScrollWheelToggle bool true
ok defaults com.apple.universalaccess HIDScrollZoomModifierMask integer 262144

# Disable press-and-hold for keys in favor of key repeat
ok defaults NSGlobalDomain ApplePressAndHoldEnabled bool false

# Set a blazingly fast keyboard repeat rate
ok defaults NSGlobalDomain KeyRepeat integer 0

# Avoid creating .DS_Store files on network volumes
ok defaults com.apple.desktopservices DSDontWriteNetworkStores bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
ok defaults com.apple.finder FXPreferredViewStyle string "Nlsv"

# Disable the warning before emptying the Trash
ok defaults com.apple.finder WarnOnEmptyTrash bool false

# Empty Trash securely by default
ok defaults com.apple.finder EmptyTrashSecurely bool true
