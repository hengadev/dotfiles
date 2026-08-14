ZDOTDIR=$HOME/.config/zsh

# Neovim's :terminal (toggleterm included) uses libvterm, which doesn't
# understand WezTerm's OSC 1337 shell-integration sequences from
# /etc/profile.d/wezterm.sh — they leak into the buffer as literal text.
# $NVIM is set by Neovim for any :terminal job, so skip the integration there.
if [ -n "$NVIM" ]; then
  export WEZTERM_SHELL_SKIP_ALL=1
fi
