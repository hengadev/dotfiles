# sway role

Installs the sway/Wayland desktop stack that the `sway`, `waybar`, and
`wofi` configs in this repo depend on.

**What it installs:**
- `sway`, `waybar`, `wofi` — compositor, status bar, launcher
- `dex` (`dex-autostart` on Fedora) — XDG autostart
- `xss-lock` + `i3lock` — idle-triggered screen locking
- `network-manager-gnome` (`network-manager-applet` on Fedora) — `nm-applet` tray icon
- `wireplumber` — `wpctl` volume control
- `brightnessctl` — brightness keys
- `pavucontrol` — audio mixer (waybar pulseaudio click target)
- `xdg-desktop-portal` + `xdg-desktop-portal-wlr` — screen sharing/portals under sway

**Note:** package names that differ between apt and dnf live in
`vars/packages.yml` under `sway_packages_debian` / `sway_packages_redhat`.
Fonts (Nerd Fonts used by waybar/wofi icons) are handled separately by the
`fonts` role.
