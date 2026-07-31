# theme-sync

Picking an nvim/base46 theme propagates its exact palette to nvim's own
default, tmux, wezterm, herdr, waybar, and the sway wallpaper. There's one
canonical flow ([`set-theme.sh`](set-theme.sh)), reached from two entry
points: nvim's Telescope theme picker, and the `$mod+Shift+t` wofi menu
([`pick-theme.sh`](pick-theme.sh)).

## How it fits together

- **`extract-palette.lua`** - run headless by `set-theme.sh` to read a base46
  theme's `type` (light/dark) and `base_16` palette, without loading nvim's
  full config.
- **`set-theme.sh`** - the one canonical flow. Given a theme name: extracts
  its palette, persists it as nvim's default in `nvconfig.lua`, regenerates
  the tmux and wezterm palettes, patches herdr's `[theme.custom]` keys, and
  calls `apply-theme.sh`.
- **`apply-theme.sh`** - applies the light/dark bucket from `~/.theme_state`
  to waybar and the wallpaper. Also runs once at sway startup to reapply
  whatever was last saved.
- **`tmux-nvim-theme.sh`** - a fork of the `catppuccin-tmux` plugin's status
  line, sourcing colors from the generated `tmux-palette.sh` instead of a
  fixed flavour file. Only invoked by `set-theme.sh` - nothing re-runs it
  when a fresh tmux server starts (see gap below).
- **`pick-theme.sh`** - lists every base46 theme in a wofi dmenu, then hands
  the selection to `set-theme.sh`.
- **`wallpapers.sh`** - the two wallpaper paths (`WALLPAPER_DARK` /
  `WALLPAPER_LIGHT`), sourced by both `apply-theme.sh` and `setup.sh`. Edit
  this file to point at your own images.
- **`setup.sh`** - diagnostic check, see below.

## Installing on a new machine

1. **OS packages.** Required: `neovim`, `git`, `jq`, `wofi`, `sway`,
   `waybar`. Optional (skip what you don't use): `tmux`, `wezterm`,
   `python3` (only needed for the herdr integration's config patch).

2. **Clone this repo to `~/.config`.**

3. **Open `nvim` once, then quit.** `nvim/lua/gary/lazy.lua` self-bootstraps
   `lazy.nvim` via `git clone` on first launch and installs every plugin
   under `nvim/lua/plugins/`, including `NvChad/base46` - that's what
   populates `~/.local/share/nvim/lazy/base46/lua/base46/themes/`, which
   `extract-palette.lua` reads from. Just needs network + git.

4. **Reinstall tmux plugins.** `tmux/plugins/*` (catppuccin-tmux, tpm,
   tmux-sessionx, etc.) are tracked as git*links* (mode `160000`) with no
   `.gitmodules` file, so cloning this repo leaves those directories empty -
   nothing actually fetches their contents. Install TPM yourself:
   ```
   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
   ```
   then start tmux and press `prefix + I` to install the rest from
   `tmux.conf`'s `@plugin` list.

   Note: a fresh tmux server won't have the synced palette until you do one
   theme pick - `tmux-nvim-theme.sh` is only invoked by `set-theme.sh`,
   nothing runs it automatically on tmux startup. Until then you'll see
   whatever the stock `catppuccin-tmux` plugin defaults to.

5. **Wallpapers.** Not tracked by git. Copy your own images over and point
   `wallpapers.sh` at them (defaults expect
   `~/Pictures/Wallpapers/mountain.jpg` and `lofi_forest.jpg`).

6. **Run the checker:**
   ```
   ~/.config/theme-sync/setup.sh
   ```
   It auto-fixes trivial things (`chmod +x` on these scripts, the waybar
   `palette.css` symlink, seeding `~/.theme_state` to `dark`) and reports
   anything still missing from steps 1-5.

7. **Reload sway** (`$mod+Shift+c`, or a fresh login) to pick up the
   `$mod+Shift+t` binding.
