#!/bin/sh
# Set up a new Mac. Safe to run again.
# Usage: ./bootstrap/install.sh [--no-apps] [--no-macos]
set -e

cd "$(dirname "$0")/.."   # repo root regardless of caller cwd

apps=1; macos=1
for arg in "$@"; do
    case "$arg" in
        --no-apps) apps=0 ;;
        --no-macos) macos=0 ;;
    esac
done

# Homebrew (not preinstalled; Xcode CLT already provides git/curl)
if ! command -v brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# CLI tools and apps (see bootstrap/Brewfile)
if [ "$apps" = 1 ]; then
    brew bundle --file=bootstrap/Brewfile || echo "WARN: some Brewfile entries failed"
else
    brew install stow neovim tmux ripgrep tree-sitter-cli
fi

# Tools that are not in Homebrew (both self-update into ~/.local/bin)
mkdir -p "$HOME/.local/bin"
if ! command -v claude > /dev/null && [ ! -x "$HOME/.local/bin/claude" ]; then
    curl -fsSL https://claude.ai/install.sh | bash
fi
if [ ! -x "$HOME/.local/bin/herdr" ]; then
    curl -fsSL -o "$HOME/.local/bin/herdr" \
        https://github.com/herdrdev/herdr/releases/latest/download/herdr-macos-aarch64
    chmod +x "$HOME/.local/bin/herdr"
fi

# Dotfiles
shell=$(basename "$SHELL")
case "$shell" in
    zsh) ln -sf .config/shell/profile .zprofile ;;
    *) echo "Shell $shell is not supported." ;;
esac

command -v stow > /dev/null || { echo "stow is not present"; exit 1; }
stow --no-folding .

# macOS settings
[ "$macos" = 1 ] && sh bootstrap/macos.sh

echo
echo "Done. Finish the manual steps in bootstrap/MANUAL.md."
