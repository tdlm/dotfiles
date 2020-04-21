#!/usr/bin/env bash

#                               ____            __
#  /'\_/`\                     /\  _`\         /\ \__
# /\      \     __      ___    \ \,\L\_\     __\ \ ,_\  __  __  _____
# \ \ \__\ \  /'__`\   /'___\   \/_\__ \   /'__`\ \ \/ /\ \/\ \/\ '__`\
#  \ \ \_/\ \/\ \L\.\_/\ \__/     /\ \L\ \/\  __/\ \ \_\ \ \_\ \ \ \L\ \
#   \ \_\\ \_\ \__/.\_\ \____\    \ `\____\ \____\\ \__\\ \____/\ \ ,__/
#    \/_/ \/_/\/__/\/_/\/____/     \/_____/\/____/ \/__/ \/___/  \ \ \/
#                                                                 \ \_\
#                                                                  \/_/

# =====
# Base variables
# =====
CURRENT_DIR="$(dirname $0)"

# =====
# Includes
# =====
source ${CURRENT_DIR}/common/colors.sh
source ${CURRENT_DIR}/common/functions.sh

# =====
# Main installation script
# =====
section_header "Introduction"
echo "Scott's new Mac setup script."
echo "Before we get started. Let's confirm some things..."

read -p "Name? [${ul}Scott Weaver${normal}] " setup_name
setup_name=${setup_name:-Scott Weaver}
read -p "Email? [${ul}scottmweaver@gmail.com${normal}] " setup_email
setup_email=${setup_email:-scottmweaver@gmail.com}
read -p "Github user? [${ul}tdlm${normal}] " setup_github_user
setup_github_user=${setup_github_user:-tdlm}

# SSH Key
section_header "SSH Key"
generate_ssh_key

# XCode
section_header "XCode"
install_xcode
install_xcode_cli_tools

# Install/Update Homebrew
section_header "Homebrew"
install_and_configure_homebrew

# Install and configure Git
section_header "Git"
install_and_configure_git

# Homebrew extras and clean-up
section_header "Baseline Brew Apps"
install_brew_baseline_apps

# Dotfiles
section_header "Dotfiles"
install_dotfiles
update_dotfile_submodules

# Gulp
section_header "Gulp"
install_gulp

# Pure Prompt
section_header "Pure Prompt"
install_pure_prompt

# ColorLS
section_header "ColorLS"
install_colorls

# CocoaPods (Dependency manager for Swift/Objective-C)
section_header "CocoaPods"
install_cocoapods

# ZSH
# section_header "Oh My ZSH"
# install_ohmyzsh - Disabling for now since submodules should handle this.

# Applications
section_header "Applications"
install_mac_apps

# Mac App Store Apps
section_header "Mac App Store Applications"
install_mac_store_apps

# Set Vim up
section_header "VI/VIM Setup"
set_vim_up

# Mac Preferences
section_header "Mac Preferences"
set_mac_preferences

# Clean up
section_header "Cleanup"
echo "Homebrew cleanup..."
brew cleanup

# One More Thing
section_header "One More Thing..."
echo "Just in case, let's run brew doctor to see if there's anything needing to be addressed..."
brew doctor

echo "✨ Done ✨"