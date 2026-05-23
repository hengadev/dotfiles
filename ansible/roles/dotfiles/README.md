# dotfiles role

Clones the dotfiles repository into `~/.config`.

**What it does:**
- On a fresh machine: initializes `~/.config` as a git repo and pulls from `dotfiles_repo`
- On an existing setup: runs `git pull` to update
- Initializes git submodules (zsh plugins etc.)

**Variables (set in `defaults/main.yml`):**
- `dotfiles_repo`: Git URL of your dotfiles repository
- `dotfiles_branch`: Branch to checkout (default: `main`)
- `dotfiles_dest`: Where to clone (default: `~/.config`)

**Note:** The dotfiles repository IS `~/.config` — it is not cloned into a subdirectory.
