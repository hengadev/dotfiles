###--- Aliases ---###
source $HOME/.config/zsh/aliases.zsh
source ~/.nvm/nvm.sh

# Pour golang, rust neovim. 
source ~/.profile

# Enable vi mode
bindkey -v

# Just need to clone the repo on github in the current dir.
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
export MANPAGER='nvim +Man!'


# NOTE: Pour pouvoir mettre la conf ici, il me faut le zshenv ou je precise la 
# variable ZDOTDIR.

