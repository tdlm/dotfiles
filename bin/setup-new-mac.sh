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

# Colors available:
#   black=$(tput setaf 0)
#   red=$(tput setaf 1)
#   green=$(tput setaf 2)
#   yellow=$(tput setaf 3)
#   blue=$(tput setaf 4)
#   magenta=$(tput setaf 5)
#   cyan=$(tput setaf 6)
#   white=$(tput setaf 7)
#   dim=$(tput setaf 8)
#   normal=$(tput sgr0)
magenta=$(tput setaf 5)
normal=$(tput sgr0)
ul=$(tput smul)

# =====
# Display a colored "section" header
# =====
section_header() {
    printf "%s\n" "" "${magenta}===${normal} $1 ${magenta}===${normal}" ""
}

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
read -p "Shall we generate an SSH key? (${ul}Y${normal}|n)" setup_create_ssh_key
setup_create_ssh_key=${setup_create_ssh_key:-y}

if [[ ${setup_create_ssh_key} == "yes" ]] ||  [[ ${setup_create_ssh_key} == "Y" ]] || [[ ${setup_create_ssh_key} == "y" ]]; then
  ssh-keygen -t rsa

  echo "Please take the above output and add it to your GitHub/GitLab accounts."
  echo "https://github.com/settings/keys"
  read -p "Press [Enter] to continue when you're ready..."
else
  echo "Skipping..."
fi

# Install XCode
section_header "XCode Install"

read -p "Shall we run XCode install? (${ul}Y${normal}|n)" setup_xcode_install
setup_xcode_install=${setup_xcode_install:-y}
if [[ ${setup_xcode_install} == "yes" ]] ||  [[ ${setup_xcode_install} == "Y" ]] || [[ ${setup_xcode_install} == "y" ]]; then
  echo "Setting up XCode..."
  xcode-select --install
else
  echo "Skipping..."
fi

# Install/Update Homebrew
section_header "Homebrew"
echo "Checking to see if we have Homebrew installed..."
if command -v brew &>/dev/null; then
  echo "Homebrew installed. Skipping installation..."
else
  echo "Homebrew not found. Installing..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "Updating Homebrew..."
brew update

# Install and configure Git
section_header "Install and configure Git"
if command -v git &>/dev/null; then
  echo "Git command found. Skipping..."
else
  echo "Git not found. Installing..."
  brew install git

  echo "Set Git default config values..."
  git config --global user.name $setup_name
  git config --global user.email $setup_email
  git config --global alias.logline 'log --graph --pretty=format:'"'"'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"'"' --abbrev-commit'
  git config --global alias.line '!git diff --numstat HEAD~ | awk '"'"'{a+=$1;next;}; END{print a;}'"'"''

  echo "Installing Brew Git utilities..."
  brew install git-extras
  brew install git-flow
fi

# Create Required Directories
section_header "Required Directories"
echo "Create required directories..."
mkdir -p ~/.nvm

# Homebrew extras and clean-up
section_header "Baseline Brew Apps"
echo "Install Brew baseline apps..."
brew_extras=(
    awscli
    awslogs
    composer
    docker-compose
    figlet
    jq
    node
    nvm
    php
    ruby
    svn
    tree
    wget
    zsh
)
brew install ${brew_extras[@]}

# Link kegs
echo "Linking Brew kegs..."
brew link --overwrite docker-compose
brew link libimobiledevice
brew link --overwrite php@7.2
brew link --overwrite python

# Dotfiles
section_header "Dotfiles"

read -p "Shall we run install Dotfiles? (${ul}Y${normal}|n)" setup_install_dotfiles
setup_install_dotfiles=${setup_install_dotfiles:-y}
if [[ ${setup_install_dotfiles} == "yes" ]] ||  [[ ${setup_install_dotfiles} == "Y" ]] || [[ ${setup_install_dotfiles} == "y" ]]; then
  echo "Installing Dotfiles from repository..."
  cd ~
  git clone --recursive git@github.com:$setup_github_user/dotfiles.git .dotfiles
  alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  dotfiles checkout
else
  echo "Skipping..."
fi

# Gulp
section_header "Gulp"

if command -v gulp &>/dev/null; then
  echo "Gulp command found. Skipping..."
else
  echo "Gulp command not found. Installing..."
  npm i -g gulp-cli
fi

# Pure Prompt
section_header "Pure Prompt"

if npm list -g pure-prompt --depth=0 &>/dev/null; then
  echo "Pure prompt found. Skipping..."
else
  echo "Pure prompt not found. Installing..."
  npm i -g pure-prompt
fi

# ColorLS
section_header "ColorLS"

echo "ColorLS most likely needs your password."

if sudo gem list colorls | grep colorls &>/dev/null; then
  echo "ColorLS found. Skipping..."
else
  echo "ColorLS not found. Installing..."
  sudo gem install colorls
fi

# ZSH
section_header "Install Oh My ZSH"

read -p "Shall we run install Oh My ZSH? (${ul}Y${normal}|n)" setup_install_ohmyzsh
setup_install_ohmyzsh=${setup_install_ohmyzsh:-y}
if [[ ${setup_install_ohmyzsh} == "yes" ]] ||  [[ ${setup_install_ohmyzsh} == "Y" ]] || [[ ${setup_install_ohmyzsh} == "y" ]]; then
  echo "Running installer..."
  cd ~
  sh -c .oh-my-zsh/tools/install.sh
else
  echo "Skipping..."
fi

if echo $SHELL | grep -i zsh &>/dev/null; then
  echo "ZSH already set as shell. Skipping..."
else
  echo "Setting ZSH as shell..."
  chsh -s /bin/zsh
fi

# Applications
section_header "Install Applications"

read -p "Shall we install applications? (${ul}Y${normal}|n)" setup_install_apps
setup_install_apps=${setup_install_apps:-y}
if [[ ${setup_install_apps} == "yes" ]] ||  [[ ${setup_install_apps} == "Y" ]] || [[ ${setup_install_apps} == "y" ]]; then
  read -p "Where would you like to install applications? [${ul}~/Applications/${normal}] " setup_app_dir
  setup_app_dir=${setup_app_dir:-~/Applications/}
  echo "Installing applications to ${setup_app_dir}..."

  apps=(
      # Browsers
      brave-browser
      firefox
      google-chrome
      microsoft-edge

      # Communications
      discord
      skype
      skype-for-business
      slack
      telegram-desktop
      zoomus

      # Dev
      cyberduck # File transfers (FileZilla is evil)
      docker
      gas-mask
      iterm2
      kitematic
      jetbrains-toolbox
      phpstorm
      postman
      sequel-pro
      sourcetree
      sublime-text
      virtualbox
      visual-studio-code

      # Productivity
      1password
      1password-cli
      alfred
      bartender
      blue-jeans
      charles
      rectangle
      tripmode
      toggl

      # Security
      backblaze
      malwarebytes
      private-internet-access

      # Video
      vlc
  )
  brew cask install --appdir=$setup_app_dir ${apps[@]}

  brew cask alfred link
else
  echo "Skipping..."
fi

# Mac App Store Apps
section_header "Install Mac App Store Applications"

read -p "Shall we install App Store applications? (${ul}Y${normal}|n)" setup_install_macapps
setup_install_macapps=${setup_install_macapps:-y}
if [[ ${setup_install_macapps} == "yes" ]] ||  [[ ${setup_install_macapps} == "Y" ]] || [[ ${setup_install_macapps} == "y" ]]; then
  echo "Installing App Store applications..."
  brew install mas
  mas_apps=(
      918207447 # Annotate - Capture and Share
      409789998 # Twitter
  )
  mas install ${mas_apps[@]}
else
  echo "Skipping..."
fi

# Clean up
section_header "Cleanup"
echo "Homebrew cleanup..."
brew cleanup

# Mac Preferences
echo "Setting Mac preferences..."
osascript -e 'tell application "System Events" to set the autohide of the dock preferences to true'

echo "✨ Done ✨"