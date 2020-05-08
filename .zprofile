# .zprofile
# Sourced at the start of a login shell. Alternative to .zlogin, but sourced directly
# before .zshrc, while .zlogin is directly sourced after it.

# $PATH inherited from /etc/paths and /etc/paths.d/
# So we prepend rather than append
# And we do it in order from least important to most:

PATH=/usr/local/sbin:$PATH
PATH=$HOME/bin:$PATH
PATH=$HOME/.composer/vendor/bin:$PATH
PATH=/usr/local/opt/php@7.2/sbin:$PATH
PATH=/usr/local/opt/php@7.2/bin:$PATH
PATH=/usr/local/opt/python/bin:$PATH
PATH=/usr/local/opt/ruby/bin:$PATH
PATH=/usr/local/opt/qt/bin:$PATH
PATH=$HOME/go/bin:$PATH
