#!/bin/sh
# General shell aliases 
alias nv="nvim"
alias ll="ls -la"
alias c="clear"
alias conf="cd ~/.config"
alias pj="cd ~/Documents/mesProjetsDev"
alias src="source ~/.config/zsh/.zshrc"

# navigation
alias ..="cd .." #
#Je rajoute le sudo pour pouvoir faire des commandes sudo, car sinon le shell n'interpretera pas maj car sudo n'est pas un alias
alias sudo="sudo "
alias maj="apt update && apt upgrade -y && rustup update"

#tmux aliases 
# Attaches tmux to the last session; creates a new session if none exists.
alias t='tmux attach || tmux new-session'
# Attaches tmux to a session (example: ta portal)
alias ta='tmux attach -t'
# Creates a new session
alias tn='tmux new'
# Lists all ongoing sessions
alias tl='tmux list-sessions'
# Pour mon ide (inspire du workflow de devaslife) 
# alias ide='tmux split-window -v -p 30 && tmux split-window -h -p 66 && tmux split-window -h -p 30'
# WARNING: Je n'utilise plus cela maintenant que j'ai mon toggleterm dans neovim.
# alias ide='tmux split-window -v -p 30' 

# npm aliases 
alias ni="npm install"
alias nrb="npm run build"
alias nrs="npm run start"
alias nrd="npm run dev"
alias nrt="npm run test"

# pnpm aliases 
alias pi="pnpm install"
alias prb="pnpm run build"
alias prs="pnpm run start"
alias prd="pnpm run dev"
alias prt="pnpm run test"

# Je rajoute des alias pour pouvoir utilise curl pour le dev 
alias cll="curl 'http://localhost:5000"

#golang aliases
alias gor="go run ."
alias got="go test -v"
alias gotb="go test -bench=." #Pour le bench sequentiel de base 
alias gotc="go test -cover" # To see the coverage of the tests written

# rust aliases
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias cc="cargo check"

#git aliases
alias g="git"
alias gs="git status -s"
alias ga="git add"
alias gp="git push"
alias gf="git fetch"
alias pr="git pull --rebase"
alias gd="git diff"
alias ci="git commit --verbose"
alias amend="git commit -a --amend --no-edit"
alias co="git checkout"
alias sw="git switch"
alias rb="git rebase"
alias rh="git reset HEAD"
alias rf="git reflog"
alias rs="git restore --staged"
alias gr="git remote -v"
alias gl="git log --oneline -n 5 --graph"
alias dog="git log --all --decorate --oneline --graph"
alias bk="git reset --hard HEAD@{1}"

# branch
alias br="git branch"
alias bra="git branch --all"
alias brd="git branch -D"
# worktree
alias gw="git worktree"
alias gwl="git worktree list"
alias gwa="git worktree add"
alias gwr="git worktree remove"

alias gb="git bisect"

# TODO: docker
alias di="docker images"


alias lg="lazygit" # Launch lazygit
# alias ld="~/go/bin/lazydocker" # Launch lazydocker
alias ld="lazydocker" # Launch lazydocker

# TODO: D'autres commandes a venir

# makefile command (since I use them a lot)
# alias make="make -f local.makefile"
# alias mt="make -f local.makefile test"
# alias mr="make -f local.makefile run"
# alias mb="make -f local.makefile build"
# alias mp="make -f local.makefile proto"
# alias md="make -f local.makefile docker"

# Mon journal de bord
alias todo="cd ~/Documents/perso/ && nv Todo.md"
alias note="cd ~/Documents/perso/ && nv Note.md"
alias idea="cd ~/Documents/perso/Projets/Idees/ && nv idea.md"

alias jdb="cd ~/Documents/perso/ && nv jdb.md"

# lampp (pour gerer php)
alias lampps="sudo /opt/lampp/lampp start"
alias lamppd="sudo /opt/lampp/lampp stop"
# open the file of my different php project.
alias phpf="cd /opt/lampp/htdocs"

alias ol="ollama list"
alias or="ollama run qwen2.5-coder:1.5b"
