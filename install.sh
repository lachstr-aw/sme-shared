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

echo "Installing kubectx..."
brew install kubectx

echo "Installing helm..."
brew install helm helmfile

echo "Installing bumpversion..."
brew install bumpversion

echo "Installing kube-forwarder..."
brew install kube-forwarder

echo "Installing lens..."
brew install lens

echo "Running brew cleanup..."
brew cleanup

echo ""

if [ -z $GITLAB_USERNAME ] || [ -z $GITLAB_TOKEN ]; then
    echo "No Gitlab configuration details found."
    echo "Get your token here: https://gitlab.awx.im/-/profile/personal_access_tokens"
    read -p "GITLAB_USERNAME=" GITLAB_USERNAME;
    read -p "GITLAB_TOKEN=" GITLAB_TOKEN;
    echo "Writing your details to ~/.zshrc"
    # write the variables to .zshrc so they can be used in future sessions
    echo "export GITLAB_USERNAME="$GITLAB_USERNAME"" >> ~/.zshrc;
    echo "export GITLAB_TOKEN="$GITLAB_TOKEN"" >> ~/.zshrc;
    echo "Restart your shell or run source ~/.zshrc to load your Gitlab credentials."
else
    echo "Gitlab details found!"
    echo "echo GITLAB_USERNAME=$GITLAB_USERNAME"
    echo "echo GITLAB_TOKEN=$GITLAB_TOKEN"
fi

if test ! "$(which gcloud)"; then
    echo "ERROR: gcloud is not installed."
    echo "Install gcloud and rerun this script."
else
    echo "glcoud is already installed! Configuring gcloud for docker..."
    gcloud auth configure-docker
fi

echo ""
echo "All done! Confirm the script finished without errors."
