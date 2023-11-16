###--- Aliases ---###
source $HOME/.config/zsh/aliases.zsh
source ~/.nvm/nvm.sh

# Pour golang, rust neovim et une var liee a java pour lancer logisim.
source ~/.profile

# Enable vi mode
bindkey -v

source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source /home/henga/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/henga/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# NOTE: Pour pouvoir mettre la conf ici, il me faut le zshenv ou je precise la 
# variable ZDOTDIR.

