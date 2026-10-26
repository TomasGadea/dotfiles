# read by every zsh, also the non-interactive ones that ssh runs for a command
# (the moshi session picker runs `herdr session list --json`, mosh runs `mosh-server`),
# so keep only the PATH entries those commands need here; the rest stays in .zprofile
typeset -U path
path=("$HOME/.local/bin" /opt/homebrew/bin $path)
