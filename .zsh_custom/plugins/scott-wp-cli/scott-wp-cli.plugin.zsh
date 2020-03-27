# Scott WP_CLI
# A rip-off of the wp-cli ohmyzsh plugin that works with Docker.
# https://wp-cli.org/

# Custom
alias dwp='dev wp'

# Cache

# Cap

# CLI

# Comment

# Core
alias wpcc='dev wp core config'
alias wpcd='dev wp core download'
alias wpci='dev wp core install'
alias wpcii='dev wp core is-installed'
alias wpcmc='dev wp core multisite-convert'
alias wpcmi='dev wp core multisite-install'
alias wpcu='dev wp core update'
alias wpcudb='dev wp core update-db'
alias wpcvc='dev wp core verify-checksums'

# Cron
alias wpcre='dev wp cron event'
alias wpcrs='dev wp cron schedule'
alias wpcrt='dev wp cron test'

# Db

# Eval

# Eval-File

# Export

# Help

# Import

# Media

# Menu
alias wpmc='dev wp menu create'
alias wpmd='dev wp menu delete'
alias wpmi='dev wp menu item'
alias wpml='dev wp menu list'
alias wpmlo='dev wp menu location'

# Network

# Option

# Plugin
alias wppa='dev wp plugin activate'
alias wppda='dev wp plugin deactivate'
alias wppd='dev wp plugin delete'
alias wppg='dev wp plugin get'
alias wppi='dev wp plugin install'
alias wppis='dev wp plugin is-installed'
alias wppl='dev wp plugin list'
alias wppp='dev wp plugin path'
alias wpps='dev wp plugin search'
alias wppst='dev wp plugin status'
alias wppt='dev wp plugin toggle'
alias wppun='dev wp plugin uninstall'
alias wppu='dev wp plugin update'

# Post
alias wppoc='dev wp post create'
alias wppod='dev wp post delete'
alias wppoe='dev wp post edit'
alias wppogen='dev wp post generate'
alias wppog='dev wp post get'
alias wppol='dev wp post list'
alias wppom='dev wp post meta'
alias wppou='dev wp post update'
alias wppourl='dev wp post url'

# Rewrite

# Role

# Scaffold

# Search-Replace

# Shell

# Sidebar
alias wpsbl='dev wp sidebar list'

# Site

# Super-Admin

# Term

# Theme
alias wpta='dev wp theme activate'
alias wptd='dev wp theme delete'
alias wptdis='dev wp theme disable'
alias wpte='dev wp theme enable'
alias wptg='dev wp theme get'
alias wpti='dev wp theme install'
alias wptis='dev wp theme is-installed'
alias wptl='dev wp theme list'
alias wptm='dev wp theme mod'
alias wptp='dev wp theme path'
alias wpts='dev wp theme search'
alias wptst='dev wp theme status'
alias wptu='dev wp theme update'

# Transient

# User
alias wpuac='dev wp user add-cap'
alias wpuar='dev wp user add-role'
alias wpuc='dev wp user create'
alias wpud='dev wp user delete'
alias wpugen='dev wp user generate'
alias wpug='dev wp user get'
alias wpui='dev wp user import-csv'
alias wpul='dev wp user list'
alias wpulc='dev wp user list-caps'
alias wpum='dev wp user meta'
alias wpurc='dev wp user remove-cap'
alias wpurr='dev wp user remove-role'
alias wpusr='dev wp user set-role'
alias wpuu='dev wp user update'

# Widget
alias wpwa='dev wp widget add'
alias wpwda='dev wp widget deactivate'
alias wpwd='dev wp widget delete'
alias wpwl='dev wp widget list'
alias wpwm='dev wp widget move'
alias wpwu='dev wp widget update'


autoload -U +X bashcompinit && bashcompinit
# bash completion for the `wp` command

_wp_complete() {
	local cur=${COMP_WORDS[COMP_CWORD]}

	IFS=$'\n';  # want to preserve spaces at the end
	local opts="$(dev wp cli completions --line="$COMP_LINE" --point="$COMP_POINT")"

	if [[ "$opts" =~ \<file\>\s* ]]
	then
		COMPREPLY=( $(compgen -f -- $cur) )
	elif [[ $opts = "" ]]
	then
		COMPREPLY=( $(compgen -f -- $cur) )
	else
		COMPREPLY=( ${opts[*]} )
	fi
}
complete -o nospace -F _wp_complete wp