#!/bin/sh

echo "Setting up your Mac..."
DOTFILES="~/.dotfiles"

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  # Install additional plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if test ! $(which gobrew); then
  /bin/bash -c "$(curl -sLk https://git.io/gobrew)"
  gobrew install 1.19.2
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $DOTFILES/.zshrc $HOME/.zshrc


# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

# NVM setup
mkdir ~/.nvm

# Add custom keyboard layouts
cp keyboard_layouts/* ~/Library/Keyboard\ Layouts

# Clone Github repositories
$DOTFILES/clone.sh

# Symlink the Mackup config file to the home directory
rm /Users/dmytro.liakhov/.mackup.cfg
ln -s $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

# Add aliases
ln -s $DOTFILES/aliases.zsh  $HOME/.aliases.zsh

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/.macos
