#!/bin/sh

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Add custom keyboard layouts
cp ~/.dotfiles/keyboard_layouts/*  ~/Library/Keyboard\ Layouts

mkdir ~/iterm-config
cp ~/Library/Preferences/com.googlecode.iterm2.plist ~/iterm-config

# Install gobrew
curl -sL https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | bash

# Install fish shell from backup
echo "Replacing fish shell from backup"
rm -rf ~/.config/fish
ln -s ~/.dotfiles/fish ~/.config/

FISH_PATH=$(which fish)

# Check if Fish is already in /etc/shells
if ! grep -Fxq "$FISH_PATH" /etc/shells; then
  echo "Adding Fish to /etc/shells..."
  echo "$FISH_PATH" | sudo tee -a /etc/shells
else
  echo "Fish is already in /etc/shells."
fi

# Change the default shell to Fish
echo "Changing the default shell to Fish..."
chsh -s "$FISH_PATH"

echo "Default shell changed to Fish. Please restart your terminal."
