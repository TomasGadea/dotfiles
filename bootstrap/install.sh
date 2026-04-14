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
	# Stow aborts on any conflict (absolute symlinks, existing files, etc).
	# Strategy: keep retrying stow, moving conflicting targets aside each
	# time, then restore them after stow succeeds.
	tmpdir=$(mktemp -d)
	max_attempts=20
	attempt=0
	while true; do
		output=$(stow . 2>&1) && break # success, done
		attempt=$((attempt + 1))
		if [ "$attempt" -ge "$max_attempts" ]; then
			echo "stow failed after $max_attempts attempts:"
			echo "$output"
			rm -rf "$tmpdir"
			exit 1
		fi
		# Extract conflicting file paths from stow's error output.
		# Stow errors look like:
		#   * existing target is an absolute symlink: .local/bin/poetry
		#   * existing target is neither a link nor a directory: .config/foo
		conflicts=$(echo "$output" | sed -n 's/.*existing target is [^:]*: *//p')
		if [ -z "$conflicts" ]; then
			echo "stow failed with unexpected error:"
			echo "$output"
			rm -rf "$tmpdir"
			exit 1
		fi
		echo "$conflicts" | while read -r f; do
			if [ -e "$HOME/$f" ] || [ -L "$HOME/$f" ]; then
				mkdir -p "$tmpdir/$(dirname "$f")"
				mv "$HOME/$f" "$tmpdir/$f"
				echo "  moved aside: $f"
			fi
		done
	done
	# Restore the original files over the symlinks stow created
	if [ -d "$tmpdir" ]; then
		cd "$tmpdir"
		find . \( -type f -o -type l \) | while read -r f; do
			f="${f#./}"
			rm -f "$HOME/$f"
			mkdir -p "$HOME/$(dirname "$f")"
			mv "$f" "$HOME/$f"
			echo "  restored: $f"
		done
		cd "$HOME/dotfiles"
		rm -rf "$tmpdir"
	fi
	echo "stow complete (conflicts were skipped)"
else
	stow .
fi
