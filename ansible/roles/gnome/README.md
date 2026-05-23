# gnome role

Applies GNOME desktop settings. Only runs on GNOME sessions.

**What it does:**
- Loads any `*.ini` dconf dump files found in `~/.config/dconf/`
- Installs gnome-tweaks and gnome-shell-extensions

**To export current GNOME settings:**
```bash
dconf dump / > ~/.config/dconf/settings.ini
```

**Note:** This role is automatically skipped when `$XDG_CURRENT_DESKTOP` does not contain `GNOME`.
