#!/usr/bin/env bash

# Check for Homebrew, and then install it
if test ! "$(which brew)"; then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Homebrew installed successfully"
else
    echo "Homebrew already installed!"
fi

# Updating Homebrew.
echo "Updating Homebrew..."
brew update

# Upgrade any already-installed formulae.
echo "Upgrading Homebrew..."
brew upgrade

echo "Installing Docker..."
brew cask install docker

echo "Installing just..."
brew install just

echo "Installing kind..."
brew install kind

echo "Installing kubectx"
brew install kubectx

echo "Installing helm..."
brew install helm helmfile

echo "Installing bumpversion..."
brew install bumpversion

echo "Installing kube-forwarder"
brew install kube-forwarder

echo "Installing lens..."
brew install lens

while true; do
    read -p "Would you like to add your Gitlab credentials to ~/.zshrc? [Y/n]" yn
    case $yn in
        [Yy]* ) read -p "Gitlab username: " GITLAB_USERNAME;
                read -p "Gitlab token: " GITLAB_TOKEN;
                echo "export GITLAB_USERNAME="$GITLAB_USERNAME"" >> ~/.zshrc;
                echo "export GITLAB_TOKEN="$GITLAB_TOKEN"" >> ~/.zshrc;
                source ~/.zshrc;
                break;;
        [Nn]* ) exit;;
        * ) echo "Please answer [Y/n].";;
    esac
done

# Remove outdated versions from the cellar.
echo "Running brew cleanup..."
brew cleanup
echo "You're done!"
