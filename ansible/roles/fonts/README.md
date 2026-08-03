# fonts role

Installs the Nerd Fonts referenced by the desktop configs (waybar, wofi, wezterm, sway).

**What it does:**
- Downloads and installs FiraCode Nerd Font and Hack Nerd Font to `~/.local/share/fonts/NerdFonts`
- Refreshes the font cache (`fc-cache`)
- Idempotent — skips the download if the fonts are already present

**Note:** Installed at the user level (no root required) — fontconfig picks up `~/.local/share/fonts` automatically.
