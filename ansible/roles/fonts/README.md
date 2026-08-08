# fonts role

Installs the Nerd Font referenced by the desktop configs (waybar, wofi, wezterm).

**What it does:**
- Downloads and installs FiraCode Nerd Font to `~/.local/share/fonts/NerdFonts`
- Refreshes the font cache (`fc-cache`)
- Idempotent — skips the download if the font is already present

**Note:** Hack Nerd Font is intentionally not installed — sway's config
references it, but only for the mode-indicator popup (e.g. resize mode);
titlebars are disabled (`default_border pixel 0`) and waybar/wofi both use
FiraCode Nerd Font already, so it isn't worth the extra download.

**Note:** Installed at the user level (no root required) — fontconfig picks up `~/.local/share/fonts` automatically.
