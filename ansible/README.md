# Ansible Bootstrap

Bootstraps a fresh Ubuntu/Debian machine with all dotfiles and development tools.

## Quick Start

```bash
# Full bootstrap (installs everything)
make bootstrap

# Or run directly
cd ~/.config
ansible-playbook -i ansible/inventory ansible/bootstrap.yml --ask-become-pass
```

## Prerequisites

```bash
sudo apt install ansible
```

## Makefile Targets

| Target | Description |
|--------|-------------|
| `make bootstrap` | Full setup — all roles |
| `make dotfiles` | Sync dotfiles only |
| `make shell` | Shell setup only |
| `make neovim` | Neovim setup only |
| `make languages` | Language runtimes only |
| `make gnome` | GNOME settings only |
| `make check` | Dry-run (no changes made) |
| `make verbose` | Full run with `-vvv` output |
| `make help` | Show all targets |

## Roles

| Role | Description |
|------|-------------|
| `system` | Base packages, lazygit, lazydocker |
| `dotfiles` | Clone dotfiles repo into `~/.config` |
| `shell` | zsh default shell, `.zshenv`, starship |
| `languages` | nvm/Node, rustup/Rust, Go, Bun |
| `neovim` | Neovim + Lazy plugin sync |
| `gnome` | dconf settings (GNOME only) |

## Configuration

Edit `roles/dotfiles/defaults/main.yml` to set your dotfiles repo URL:

```yaml
dotfiles_repo: "git@github.com:YourUsername/.config.git"
```

Edit `vars/packages.yml` to customize which packages get installed.

## Notes

- **Idempotent**: safe to re-run at any time
- **The dotfiles repo IS `~/.config`** — it is not cloned into a subdirectory
- The `gnome` role is automatically skipped on non-GNOME systems
- SSH keys must be set up before running if using `git@github.com:...` URLs
