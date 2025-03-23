# Shortcuts
alias c="clear"

alias k="kubectl"
alias kc="kubectx"
alias mux="tmuxinator"

alias reloadfish="source ~/.config/fish/config.fish"

# Directories
alias fishfiles="cd $FISH_PATH"
alias dotfiles="cd $DOTFILES"

# Git
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="git commit -m wip"
alias fetchall="git fetch --all"
alias rebase="git rebase"
alias dc="docker compose"
alias d="docker"

# IDEA and Toolbox
alias idea="/Users/dliakhov/Library/Application\ Support/JetBrains/Toolbox/scripts/idea"