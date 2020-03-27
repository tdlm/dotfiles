#.zshenv
# Always sourced, it often contains exported variables that should be available to other
# programs. For example, $PATH, $EDITOR, and $PAGER are often set in .zshenv. Also, you
# can set $ZDOTDIR in .zshenv to specify an alternative location for the rest of your
# zsh configuration.

PATH=/usr/local/sbin:$PATH
PATH=/usr/local/bin:$PATH
PATH=/usr/bin:$PATH
PATH=/bin:$PATH
PATH=$PATH:$HOME/.composer/vendor/bin
PATH=/usr/local/opt/ruby/bin:$PATH

# PHP Flags
PATH=/usr/local/opt/php@7.2/bin:$PATH
PATH=/usr/local/opt/php@7.2/sbin:$PATH

# PHP Runtime Flags
LDFLAGS="-L/usr/local/opt/php@7.2/lib"
CPPFLAGS="-I/usr/local/opt/php@7.2/include"

export PATH=${PATH}