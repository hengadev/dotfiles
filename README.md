# config

Personal dotfiles, managed with Ansible and cloned directly into `~/.config`. Tested on Debian/Ubuntu and Fedora/RHEL; the `system`, `shell`, `neovim`, and `gnome` roles pick the right package manager (`apt` or `dnf`) automatically.

## New machine setup

**Prerequisites:**

- Ansible and git installed
- An SSH key on the machine that's added to your GitHub account (the dotfiles role clones over SSH)

```sh
# Debian/Ubuntu
sudo apt update && sudo apt install -y ansible git

# Fedora/RHEL
sudo dnf install -y ansible git
```

**Then, on any distro:**

```sh
git clone git@github.com:hengadev/dotfiles.git ~/.config
cd ~/.config
make bootstrap
```

`make bootstrap` re-clones itself properly into `~/.config` (the initial clone above just gets you the `Makefile`/`ansible/` files needed to run it) and installs everything: system packages, shell, languages, neovim, and — on GNOME desktops only — GNOME settings/extensions.

## Bootstrap

```sh
make bootstrap   # full setup (all roles, prompts for sudo)
make dotfiles    # just symlink dotfiles
make check       # dry run
make help        # list all targets
```

See `Makefile` for individual role targets (shell, neovim, languages, gnome).

## Layout

Each top-level directory is a tool's config (`nvim`, `sway`, `waybar`, `zsh`, `tmux`, `alacritty`, `wezterm`, `wofi`, `kanata`, `git`, `starship`, ...). A few are supporting tooling rather than app config:

- `ansible/` — bootstrap playbook and roles
- `theme-sync/` — keeps terminal/app themes in sync on theme switch
- `to_root/`, `gotoroot/` — helper scripts

Untracked directories (caches, app-generated state) are excluded via `.gitignore`.
