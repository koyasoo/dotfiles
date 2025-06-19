#!/bin/sh

# Constants
LOG_FILE="/tmp/setup_log.txt"
SCRIPT_DIR_PATH=$(cd $(dirname $0); pwd)
HAMMERSPOON_CONFIG_PATH="$HOME/.hammerspoon/init.lua"
HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
MAC_MOUSE_SPEED=8

# Logging function
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "${LOG_FILE}"
}

# Error handling function
handle_error() {
  log "ERROR: $1"
  echo "ERROR: $1"
  exit 1
}

# Hammerspoon setup
setup_hammerspoon() {
  mkdir -p "$HOME/.hammerspoon" || handle_error "Failed to create Hammerspoon directory."
  ln -fns "${SCRIPT_DIR_PATH}/.hammerspoon/init.lua" "${HAMMERSPOON_CONFIG_PATH}" || handle_error "Failed to link Hammerspoon configuration."
  log "Hammerspoon configuration linked to ${HAMMERSPOON_CONFIG_PATH}."
  echo "Hammerspoon setup completed."
}

# Homebrew installation
install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL ${HOMEBREW_INSTALL_URL})" || handle_error "Homebrew installation failed."
    log "Homebrew installed successfully."
    echo "Homebrew installation completed."
  else
    log "Homebrew is already installed."
    echo "Homebrew is already installed."
  fi
}

# Homebrew packages installation
install_packages() {
  echo "Installing packages via Homebrew..."
  brew bundle || handle_error "Homebrew Bundle execution failed."
  log "Packages installed successfully via Homebrew."
  echo "Package installation completed."
}

# macOS settings configuration
configure_mac_settings() {
  defaults write "Apple Global Domain" com.apple.mouse.scaling "${MAC_MOUSE_SPEED}" || handle_error "Failed to set mouse speed."
  log "Mouse speed set to ${MAC_MOUSE_SPEED}."

  defaults write com.apple.dock ResetLaunchPad -bool true || handle_error "Failed to reset Launchpad."
  killall Dock || handle_error "Failed to restart Dock."
  log "Launchpad reset."

  defaults write com.apple.finder AppleShowAllFiles -bool true || handle_error "Failed to show hidden files in Finder."
  log "Hidden files are now visible in Finder."

  defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true || handle_error "Failed to enable Xcode build duration display."
  log "Xcode is now showing build operation duration."

  defaults write com.apple.iphonesimulator ShowSingleTouches 1 || handle_error "Failed to enable single touches in iOS simulator."
  log "Single touches are now shown in iOS simulator."

  defaults write com.apple.dt.XCBuild EnableSwiftBuildSystemIntegration 1 || handle_error "Failed to enable Swift build system integration."
  log "Swift build system integration enabled."

  killall SystemUIServer || handle_error "Failed to restart SystemUIServer."
  log "SystemUIServer restarted."

  echo "macOS settings configured successfully."
}

# Environment check
check_environment() {
  if [ "$(uname)" != "Darwin" ]; then
    handle_error "This script can only be executed on macOS."
  fi
}

# Main script execution
main() {
  check_environment
  setup_hammerspoon
  install_homebrew
  install_packages
  configure_mac_settings
  echo "Setup completed successfully."
}

main
