cask_apps=(
    # Browsers
    firefox                         # Firefox.
    google-chrome                   # Google Chrome browser.
    microsoft-edge                  # Microsoft Edge browser. By Microsoft.

    # Communications
    slack                           # Communications platform.
    zoom                            # Video conferencing software.

    # Dev
    cyberduck                       # File transfers (FileZilla is evil)
    docker                          # OS-level virtualization for containers.
    gas-mask                        # Hosts file manager.
    iterm2                          # The best terminal software for Mac.
    kitematic                       # Docker GUI.
    "local"                         # WordPress development tool.
    jetbrains-toolbox               # JetBrains tools manager (mainly for PHPStorm).
    postman                         # API interaction tool.
    sublime-text                    # Sublime Text is a cross-platform source code editor with a Python.
    trailer                         # Github workflow menubar app.
    visual-studio-code              # Source code editor developed by Microsoft.

    # Productivity
    1password                       # Digital password manager and vault.
    1password-cli                   # Command line tool for 1Password.
    alfred                          # Spotlight replacement and productivity tool.
    charles                         # HTTP proxy monitor. See all the traffic.
    # rectangle                       # Move/resize windows. Based on Spectacle / written in Swift.
    spectacle                       # Move/resize windows.
    tripmode                        # Controls which apps can access Internet connection.
)

mac_store_apps=(
    # 918207447 # Annotate - Capture and Share
    # 409789998 # Twitter
)

brew_apps=(
    awscli          # Official Amazon AWS command-line interface.
    awslogs         # awslogs is a simple command line tool for querying Amazon CloudWatch logs.
    composer        # Dependency manager for PHP.
    docker-compose  # Isolated dev environments using Docker.
    fd              # Simple, fast and user-friendly alternative to find.
    figlet          # FIGlet is a program for making large letters out of ordinary text.
    go              # Golang (Open source programming language).
    jq              # jq is a lightweight and flexible command-line JSON processor.
    mas             # Mac App Store command-line interface.
    node            # Node.js. A platform built on V8 for network applications.
    php             # PHP (Latest).
    php@8.0         # PHP (7.2).
    python          # Python.
    ruby            # Ruby.
    tldr            # Simplified and community-driven man pages.
    tree            # Display directory trees.
    watchman        # Watch files and take action when they change.
    wget            # Internet file retriever (curl alternative).
    zsh             # UNIX Shell. Way better than Bash.
)

# =====
# Display a colored "section" header
# =====
section_header() {
  printf "%s\n" "" "${magenta}===${normal} $1 ${magenta}===${normal}" ""
}

# =====
# Add dotfiles function
# =====
dotfiles() {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

# =====
# Generate SSH Key
# =====
generate_ssh_key() {
    read -p "Shall we generate an SSH key? (${ul}Y${normal}|n)" setup_create_ssh_key
    setup_create_ssh_key=${setup_create_ssh_key:-y}

    if [[ ${setup_create_ssh_key} == "yes" ]] ||  [[ ${setup_create_ssh_key} == "Y" ]] || [[ ${setup_create_ssh_key} == "y" ]]; then
        ssh-keygen -t rsa

        echo "Please take the above output and add it to your GitHub/GitLab accounts."
        echo "${blue}${ul}https://github.com/settings/keys${normal}"
        echo "${blue}${ul}https://gitlab.com/profile/keys${normal}"
        read -p "Press [Enter] to continue when you're ready..."
    else
        echo "Skipping..."
    fi
}

# =====
# Generate SSH Key
# =====
set_vim_up() {
    echo "Installing vim-plug (Vim plugin manager)..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

# =====
# XCode installation
# =====
install_xcode() {
    read -p "Shall we run XCode install? (${ul}Y${normal}|n)" setup_xcode_install
    setup_xcode_install=${setup_xcode_install:-y}
    if [[ ${setup_xcode_install} == "yes" ]] ||  [[ ${setup_xcode_install} == "Y" ]] || [[ ${setup_xcode_install} == "y" ]]; then
        echo "Setting up XCode. This may require your password..."
        sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
    else
        echo "Skipping..."
    fi
}

# =====
# XCode CLI Tools installation
# =====
install_xcode_cli_tools() {
    read -p "Shall we install XCode command line tools? (${ul}Y${normal}|n)" setup_xcode_cli_install
    setup_xcode_cli_install=${setup_xcode_cli_install:-y}
    if [[ ${setup_xcode_cli_install} == "yes" ]] ||  [[ ${setup_xcode_cli_install} == "Y" ]] || [[ ${setup_xcode_install} == "y" ]]; then
        echo "Setting up XCode command line tools..."
        if xcode-select -p &>/dev/null; then
            echo "XCode command line tools already installed! Skipping..."
        else
            echo "XCode command line tools not found. Installing..."
            xcode-select --install
        fi
    else
        echo "Skipping..."
    fi
}

# =====
# Update Homebrew
# =====
update_homebrew() {
    echo "Updating Homebrew..."
}

# =====
# Install and configure Homebrew
# =====
install_and_configure_homebrew() {
    echo "Checking to see if we have Homebrew installed..."
    if command -v brew &>/dev/null; then
        echo "Homebrew installed. Skipping installation..."
    else
        echo "Homebrew not found. Installing..."
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    update_homebrew
}

# =====
# Install and configure Git
# =====
install_and_configure_git() {
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
}

# =====
# Install Homebrew baseline apps
# =====
install_brew_baseline_apps() {
    echo "Install Brew baseline apps..."
    brew install ${brew_apps[@]}

    # Link kegs
    echo "Linking Brew kegs..."
    brew link --overwrite docker-compose
    brew link libimobiledevice
    brew link --overwrite php@7.2
    brew link --overwrite python
}

# =====
# Update Homebrew baseline apps
# =====
update_brew_baseline_apps() {
    echo "Update Brew baseline apps..."
    brew upgrade ${brew_apps[@]}

    brew link --overwrite docker-compose
}

# =====
# Install Dotfiles
# =====
install_dotfiles() {
    read -p "Shall we run install Dotfiles? (${ul}Y${normal}|n)" setup_install_dotfiles
    setup_install_dotfiles=${setup_install_dotfiles:-y}
    if [[ ${setup_install_dotfiles} == "yes" ]] ||  [[ ${setup_install_dotfiles} == "Y" ]] || [[ ${setup_install_dotfiles} == "y" ]]; then
        echo "Installing Dotfiles from repository..."
        cd ~
        git clone --bare --recursive git@github.com:$setup_github_user/dotfiles.git .dotfiles

        dotfiles checkout
    else
       echo "Skipping..."
    fi
}

# =====
# Update Dotfiles
# =====
update_dotfiles() {
    read -p "Shall we update Dotfiles? (${ul}Y${normal}|n)" setup_update_dotfiles
    setup_update_dotfiles=${setup_update_dotfiles:-y}
    if [[ ${setup_update_dotfiles} == "yes" ]] ||  [[ ${setup_update_dotfiles} == "Y" ]] || [[ ${setup_update_dotfiles} == "y" ]]; then
        echo "Pulling latest down from Dotfiles repository..."
        cd ~
        dotfiles pull
    else
       echo "Skipping..."
    fi
}

# =====
# Install Gulp
# =====
install_gulp() {
    if command -v gulp &>/dev/null; then
        echo "Gulp command found. Skipping..."
    else
        echo "Gulp command not found. Installing..."
        npm i -g gulp-cli
    fi
}

# =====
# Install Pure Prompt
# =====
install_pure_prompt() {
    if npm list -g pure-prompt --depth=0 &>/dev/null; then
      echo "Pure prompt found. Skipping..."
    else
        echo "Pure prompt not found. Installing..."
        npm i -g pure-prompt
    fi
}

# =====
# Install ColorLS
# =====
install_colorls() {
    echo "ColorLS most likely needs your password."

    if sudo gem list colorls | grep colorls &>/dev/null; then
        echo "ColorLS found. Skipping..."
    else
        echo "ColorLS not found. Installing..."
        sudo gem install colorls
    fi
}

# =====
# Install CocoaPods
# =====
install_cocoapods() {
    echo "CocoaPods most likely needs your password."

    if sudo gem list cocoapods | grep cocoapods &>/dev/null; then
        echo "CocoaPods found. Skipping..."
    else
        echo "CocoaPods not found. Installing..."
        sudo gem install -n /usr/local/bin cocoapods
    fi
}

# =====
# Install OhMyZSH
# =====
install_ohmyzsh() {
    read -p "Shall we run install Oh My ZSH? (${ul}Y${normal}|n)" setup_install_ohmyzsh
    setup_install_ohmyzsh=${setup_install_ohmyzsh:-y}
    if [[ ${setup_install_ohmyzsh} == "yes" ]] ||  [[ ${setup_install_ohmyzsh} == "Y" ]] || [[ ${setup_install_ohmyzsh} == "y" ]]; then
        echo "Running installer..."
        cd ~
        bash -c .oh-my-zsh/tools/install.sh
    else
        echo "Skipping..."
    fi

    if echo $SHELL | grep -i zsh &>/dev/null; then
        echo "ZSH already set as shell. Skipping..."
    else
        echo "Setting ZSH as shell..."
        chsh -s /bin/zsh
    fi
}

# =====
# Update OhMyZSH
# =====
update_ohmyzsh() {
    read -p "Shall we upgrade Oh My ZSH? (${ul}Y${normal}|n)" setup_upgrade_ohmyzsh
    setup_upgrade_ohmyzsh=${setup_upgrade_ohmyzsh:-y}
    if [[ ${setup_upgrade_ohmyzsh} == "yes" ]] ||  [[ ${setup_upgrade_ohmyzsh} == "Y" ]] || [[ ${setup_upgrade_ohmyzsh} == "y" ]]; then
        echo "Running upgrader..."
        cd ~
        env ZSH="$ZSH" sh "$ZSH/tools/upgrade.sh"
        command rm -rf "$ZSH/log/update.lock"
    else
        echo "Skipping..."
    fi
}

# =====
# Install Mac Apps via Homebrew Cask
# =====
function install_mac_apps() {
    read -p "Shall we install applications? (${ul}Y${normal}|n)" setup_install_apps
    setup_install_apps=${setup_install_apps:-y}
    if [[ ${setup_install_apps} == "yes" ]] ||  [[ ${setup_install_apps} == "Y" ]] || [[ ${setup_install_apps} == "y" ]]; then
        read -p "Where would you like to install applications? [${ul}/Applications/${normal}] " setup_app_dir
        setup_app_dir=${setup_app_dir:-/Applications/}
        echo "Installing applications to ${setup_app_dir}..."

        brew install --cask --appdir=$setup_app_dir ${cask_apps[@]}

        brew alfred link
    else
        echo "Skipping..."
    fi
}

# =====
# Update Mac Apps via Homebrew Cask
# =====
function update_mac_apps() {
    read -p "Shall we update applications? (${ul}Y${normal}|n)" setup_update_apps
    setup_update_apps=${setup_update_apps:-y}
    if [[ ${setup_update_apps} == "yes" ]] ||  [[ ${setup_update_apps} == "Y" ]] || [[ ${setup_update_apps} == "y" ]]; then
        read -p "Where would you like to install applications? [${ul}/Applications/${normal}] " setup_app_dir
        setup_app_dir=${setup_app_dir:-/Applications/}
        echo "Installing applications to ${setup_app_dir}..."

        brew install --cask --appdir=$setup_app_dir ${cask_apps[@]}

        echo "Updating out of date casks..."
        brew upgrade --cask
    else
        echo "Skipping..."
    fi
}

# =====
# Install Mac App Store apps via Homebrew Cask
# 
# NOTE: These must have already been installed/purchased.
# =====
function install_mac_store_apps() {
    read -p "Shall we install App Store applications? (${ul}Y${normal}|n)" setup_install_macapps
    setup_install_macapps=${setup_install_macapps:-y}
    if [[ ${setup_install_macapps} == "yes" ]] ||  [[ ${setup_install_macapps} == "Y" ]] || [[ ${setup_install_macapps} == "y" ]]; then
        echo "Installing App Store applications..."
        mas install ${mac_store_apps[@]}
    else
        echo "Skipping..."
    fi
}

# =====
# Update Mac App Store apps via Homebrew Cask
# 
# NOTE: These must have already been installed/purchased.
# =====
function update_mac_store_apps() {
    read -p "Shall we update App Store applications? (${ul}Y${normal}|n)" setup_update_macapps
    setup_update_macapps=${setup_update_macapps:-y}
    if [[ ${setup_update_macapps} == "yes" ]] ||  [[ ${setup_update_macapps} == "Y" ]] || [[ ${setup_update_macapps} == "y" ]]; then
        echo "Installing and upgrading App Store applications..."
        mas install ${mac_store_apps[@]}
        mas upgrade
    else
        echo "Skipping..."
    fi
}

# =====
# Set Mac preferences
# =====
function set_mac_preferences() {
    echo "Disable Dashboard..."
    defaults write com.apple.dashboard mcx-disabled -boolean YES

    echo "Set Dock autohide..."
    osascript -e 'tell application "System Events" to set the autohide of the dock preferences to true'

    echo "Restarting Dock..."
    killall Dock
}

# =====
# Update Dotfile submodules
# =====
function update_dotfile_submodules() {
    echo "Updating Dotfile submodules..."
    dotfiles submodule update --init --recursive
}
