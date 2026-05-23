# shell role

Configures zsh as the default shell and installs starship prompt.

**What it does:**
- Ensures zsh is installed
- Sets zsh as the default shell for the current user
- Creates `~/.zshenv` with `ZDOTDIR=$HOME/.config/zsh` (idempotent — skips if file exists)
- Installs starship prompt to `/usr/local/bin`

**Zsh plugins** (zsh-autosuggestions, zsh-syntax-highlighting) are part of the dotfiles
repo at `~/.config/zsh/` — the `dotfiles` role brings them in.
