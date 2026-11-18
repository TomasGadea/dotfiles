# Manual steps after install.sh

These steps need a login, a license, or a GUI permission.

- [ ] **Alfred**: enter the Powerpack license. In Preferences > Advanced, set the sync folder (for example in iCloud Drive) to restore workflows and hotkeys.
- [ ] **Logi Options+**: sign in. Restore the mouse settings from the cloud backup.
- [ ] **Tailscale**: open the app and log in.
- [ ] **Rectangle, AltTab, Alfred, Ghostty**: grant Accessibility permission (System Settings > Privacy & Security).
- [ ] **Claude Code**: run `claude` and log in.
- [ ] **gh**: run `gh auth login`.
- [ ] **SSH keys**: copy them from the old Mac or create new keys.
- [ ] **KeePassXC**: copy the database (or let Syncthing sync it).
- [ ] **Syncthing**: add the old Mac as a device and accept the shared folders.

## Keep this repo up to date

- New app or CLI tool: add it to `bootstrap/Brewfile`.
  `brew bundle cleanup --file=bootstrap/Brewfile` lists installed things that are not in the file.
- New macOS setting: run `bootstrap/defaults-diff`, change the setting, and add the key to `bootstrap/macos.sh`.
- New app preference to copy: `defaults export <domain> bootstrap/prefs/<domain>.plist`.
