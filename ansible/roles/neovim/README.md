# neovim role

Installs neovim and syncs plugins.

**What it does:**
- Adds the `neovim-ppa/unstable` PPA
- Installs neovim via apt
- Installs Python (`pynvim`) and Node (`neovim`) providers
- Runs `nvim --headless "+Lazy! sync" +qa` to install all plugins

**Requires:** `dotfiles` role to have run first (config must exist at `~/.config/nvim`).

**Requires:** `become: true` for PPA and apt steps.
