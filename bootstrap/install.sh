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
	# Move conflicting targets aside, stow, then restore them.
	# This handles absolute symlinks and existing files that stow refuses
	# to overwrite.
	tmpdir=$(mktemp -d)
	conflicts=""
	max_attempts=20
	attempt=0
	while true; do
		output=$(stow . 2>&1) && break
		attempt=$((attempt + 1))
		if [ "$attempt" -ge "$max_attempts" ]; then
			echo "stow failed after $max_attempts attempts:"
			echo "$output"
			rm -rf "$tmpdir"
			exit 1
		fi
		batch=$(echo "$output" | sed -n 's/.*existing target is [^:]*: *//p')
		if [ -z "$batch" ]; then
			echo "stow failed with unexpected error:"
			echo "$output"
			rm -rf "$tmpdir"
			exit 1
		fi
		# Save to file to avoid subshell variable loss from pipes
		echo "$batch" >"$tmpdir/_batch"
		while read -r f; do
			if [ -e "$HOME/$f" ] || [ -L "$HOME/$f" ]; then
				mkdir -p "$tmpdir/$(dirname "$f")"
				mv "$HOME/$f" "$tmpdir/$f"
				conflicts="$conflicts$f
"
				echo "  moved aside: $f"
			fi
		done <"$tmpdir/_batch"
		rm -f "$tmpdir/_batch"
	done
	# Restore original files over symlinks stow created
	echo "$conflicts" | while read -r f; do
		[ -z "$f" ] && continue
		rm -f "$HOME/$f"
		mkdir -p "$HOME/$(dirname "$f")"
		mv "$tmpdir/$f" "$HOME/$f"
		echo "  restored: $f"
	done
	rm -rf "$tmpdir"
	echo "stow complete (conflicts were skipped)"
else
	stow .
fi
