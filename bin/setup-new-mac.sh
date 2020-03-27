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

read -p "Name? [Scott Weaver] " setup_name
setup_name=${setup_name:-Scott Weaver}
read -p "Email? [scottmweaver@gmail.com] " setup_email
setup_email=${setup_email:-scottmweaver@gmail.com}
read -p "Github user? [tdlm] " setup_github_user
setup_github_user=${setup_github_user:-tdlm}

# SSH Key
section_header "SSH Key"
echo "First, let's create an SSH key for you."
ssh-keygen -t rsa

echo "Please take the above output and add it to your GitHub/GitLab accounts.\n"
echo "https://github.com/settings/keys \n"
read -p "Press [Enter] to continue when you're ready..."

# Install XCode
section_header "XCode Install"
echo "Setting up XCode..."
xcode-select --install

# Install/Update Homebrew
section_header "Homebrew"
echo "Checking to see if we have Homebrew installed..."
if command -v brew; then
  echo "Homebrew installed. Skipping installation..."
else
  echo "Homebrew not found. Installing..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "Updating Homebrew..."
brew update

# Install and configure Git
section_header "Install and configure Git"
brew install git

echo "Set Git default config values..."
git config --global user.name $setup_name
git config --global user.email $setup_email
git config --global alias.logline 'log --graph --pretty=format:'"'"'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"'"' --abbrev-commit'
git config --global alias.line '!git diff --numstat HEAD~ | awk '"'"'{a+=$1;next;}; END{print a;}'"'"''

echo "Install Brew Git utilities..."
brew install git-extras
brew install git-flow

# Create Required Directories
echo "Create required directories..."
mkdir -p ~/.nvm

# Homebrew extras and clean-up
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

# Dotfiles
section_header "Install Dotfiles"
cd ~
git clone --recursive git@github.com:$setup_github_user/dotfiles.git .dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout

# Gulp
section_header "Install Gulp"
npm i -g gulp-cli

# Pure Prompt
section_header "Pure Prompt"
npm i -g pure-prompt

# ColorLS
section_header "ColorLS"
sudo gem install colorls

# ZSH
cd ~
section_header "Install Oh My ZSH"
sh -c .oh-my-zsh/tools/install.sh

echo "Set ZSH as shell..."
chsh -s /bin/zsh

# Applications
section_header "Install Applications"

read -p "Where would you like to install applications? [~/Applications/] " setup_app_dir
setup_app_dir=${setup_app_dir:-~/Applications/}

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

# Mac App Store Apps
section_header "Install Mac App Store Applications"
brew install mas
mas_apps=(
    918207447 # Annotate - Capture and Share
    409789998 # Twitter
)
mas install ${mas_apps[@]}

# Clean up
section_header "Cleanup"
echo "Homebrew cleanup..."
brew cleanup

# Mac Preferences
osascript -e 'tell application "System Events" to set the autohide of the dock preferences to true'

echo "✨ Done ✨"