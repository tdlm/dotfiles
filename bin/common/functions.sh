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