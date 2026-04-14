#!/bin/sh

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

if ! command -v stow >/dev/null; then
	echo "stow is not present" && exit 1
fi

if [ "$1" = "--skip-conflicts" ]; then
	# Dry-run stow, collect conflicting paths, back them up, stow, then restore.
	conflicts=$(stow --no . 2>&1 | grep "existing target is" | sed 's/.*existing target is neither a link nor a directory: //')
	if [ -n "$conflicts" ]; then
		tmpdir=$(mktemp -d)
		echo "$conflicts" | while read -r f; do
			mkdir -p "$tmpdir/$(dirname "$f")"
			mv "$HOME/$f" "$tmpdir/$f"
		done
		stow .
		echo "$conflicts" | while read -r f; do
			rm -f "$HOME/$f"
			mv "$tmpdir/$f" "$HOME/$f"
		done
		rm -rf "$tmpdir"
	else
		stow .
	fi
else
	stow .
fi
