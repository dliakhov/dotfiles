if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x FISH_PATH $HOME/.config/fish
set -x DOTFILES $HOME/.dotfiles

# Set editor
set -x EDITOR "vim"

# Aliases (typically in config.fish or a separate aliases file)
source ~/.config/fish/aliases.fish
source ~/.config/fish/custom_commands.fish

# Gobrew configuration
fish_add_path $HOME/.gobrew/current/bin $HOME/.gobrew/bin

# Bat configuration
set -x BAT_THEME "Coldark-Dark"

# Golang configuration
set -x GOPATH $HOME/go
set -x GOROOT "$HOME/.gobrew/current/go"
set -x GOBIN $GOROOT/bin
set -x CGO_ENABLED 0

fish_add_path $HOME/.gobrew/current/go/bin
fish_add_path $GOPATH/bin

# fish_add_path "/opt/homebrew/share/google-cloud-sdk/bin/"

# Additional PATH additions
fish_add_path /usr/local/opt/mysql-client/bin
fish_add_path ~/google-cloud-sdk/bin
fish_add_path /usr/local/opt/libpq/bin
fish_add_path $HOME/zig
fish_add_path $HOME/zls

fish_add_path /opt/homebrew/opt/llvm@12/bin
fish_add_path $HOME/.local/bin

# Pyenv env variables
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

# Inspec Docker function
function inspec
    docker run -it --rm -v (pwd):/share chef/inspec $argv
end

set -g FZF_COMPLETION_TRIGGER '~~'
fzf --fish | source

set -U async_prompt_functions fish_right_prompt

# Direnv hook
# direnv hook fish | source

# Google Cloud SDK

# SDKMAN configuration

# RSVM configuration

# Cargo & Rust

# Pyenv configuration
pyenv init - fish | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dmytroliakhov/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/dmytroliakhov/Downloads/google-cloud-sdk/path.fish.inc'; end
