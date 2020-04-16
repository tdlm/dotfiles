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
echo "Scott's Mac update script."
echo "Before we get started. Let's confirm some things..."

read -p "Name? [${ul}Scott Weaver${normal}] " setup_name
setup_name=${setup_name:-Scott Weaver}
read -p "Email? [${ul}scottmweaver@gmail.com${normal}] " setup_email
setup_email=${setup_email:-scottmweaver@gmail.com}
read -p "Github user? [${ul}tdlm${normal}] " setup_github_user
setup_github_user=${setup_github_user:-tdlm}

# Install/Update Homebrew
section_header "Homebrew"
update_homebrew

# Homebrew extras and clean-up
section_header "Baseline Brew Apps"
update_brew_baseline_apps

# Dotfiles?
section_header "Dotfiles"
update_dotfiles
update_dotfile_submodules

# ZSH
# section_header "Oh My ZSH"
# update_ohmyzsh - Disabling for now since updating submodules should take care of this.

# Applications
section_header "Update Applications"
update_mac_apps

# Mac Preferences
section_header "Set Mac Preferences"
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