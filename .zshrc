#.zshrc
# Read when interactive. You set options for the interactive shell there with the setopt
# and unsetopt commands. You can also load shell modules, set your history options,
# change your prompt, set up zle and completion, et cetera. You also set any variables
# that are only used in the interactive shell (e.g. $LS_COLORS).
# Order of preference:
# .zshenv -> [.zprofile if login] -> [.zshrc if interactive] -> [.zlogin if login] -> [.zlogout sometimes]

export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.
DEFAULT_USER=scott
ZSH_CUSTOM=$HOME/.zsh_custom
HOMEBREW_CASK_OPTS="--appdir=~/Applications" # brew cask directory

# Enable plugins.
plugins=(
  brew            # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
  git             # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
  git-flow        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-flow
  scott-wp-cli    # My custom WP-CLI stuff.
  ssh-agent       # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent
  z               # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z
)

source $ZSH/oh-my-zsh.sh

# Custom Sources
for file in $ZSH_CUSTOM/sourced/*; do
   source "$file"
done

# Activate Pure Prompt
autoload -U promptinit; promptinit
prompt pure
prompt_newline='%666v' # Single line prompt: https://github.com/sindresorhus/pure/wiki/Customizations,-hacks-and-tweaks#single-line-prompt
PROMPT=" $PROMPT"

# PHPBrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
export PHPBREW_SET_PROMPT=1

# Colorls
COLORLS_DIR=$(gem which colorls 2>/dev/null)
COLORLS_PATH=$(dirname $COLORLS_DIR 2>/dev/null)
if ([ $? -eq 0 ]) && ([[ -e $COLORLS_PATH/tab_complete.sh ]]); then
  source $COLORLS_PATH/tab_complete.sh
  alias l='colorls --group-directories-first --almost-all'
  alias ll='colorls --group-directories-first --almost-all --long'
  alias ls='colorls'
fi
