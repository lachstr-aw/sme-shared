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
brew install docker --cask

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

echo "Running brew cleanup..."
brew cleanup

echo ""

while true; do
    read -p "Would you like to add your Gitlab credentials to ~/.zshrc? [Y/n]" yn
    case $yn in
        [Yy]* ) open https://gitlab.com/-/profile/account;
                read -p "Gitlab username: " GITLAB_USERNAME;
                open https://gitlab.com/-/profile/personal_access_tokens;
                read -p "Gitlab token: " GITLAB_TOKEN;
                # write the variables to .zshrc so they can be used in future sessions
                echo "export GITLAB_USERNAME="$GITLAB_USERNAME"" >> ~/.zshrc;
                echo "export GITLAB_TOKEN="$GITLAB_TOKEN"" >> ~/.zshrc;
                # export the variables so they can be used for this session
                export GITLAB_USERNAME="$GITLAB_USERNAME";
                export GITLAB_TOKEN="$GITLAB_TOKEN";
                break;;
        [Nn]* ) exit;;
        * ) echo "Please answer [Y/n].";;
    esac
done

echo ""

if test ! "$(which gcloud)"; then
    echo "WARNING: gcloud is not installed, you must do so before continuing"
else
    echo "glcoud is already installed!"
fi

echo "All done!"
