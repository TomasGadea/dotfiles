#!/bin/sh
set -e

cd "$(dirname "$0")/.."   # repo root regardless of caller cwd

# Homebrew (not preinstalled; Xcode CLT already provides git/curl)
if ! command -v brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# stow=required, nvim/tmux=used by EDITOR + aliases
brew install stow nvim tmux

shell=$(basename "$SHELL")
profile_path=".config/shell/profile"

case "$shell" in
    zsh)
        ln -sf $profile_path .zprofile
        ;;
    *)
        echo "Shell $shell is not supported."
        ;;
esac

command -v stow > /dev/null && stow --no-folding . && exit 0

echo "stow is not present" && exit 1
