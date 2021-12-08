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

if test ! "$(which gcloud)"; then
    echo "ERROR: gcloud is not installed xor in your PATH"
    echo "Install gcloud and rerun this script."
else
    echo "glcoud is already installed! Confirm your account is active below:"
    gcloud auth list

    DOCKERCONFIG=~/.docker/config.json
    if test -f "$DOCKERCONFIG"; then
        echo "Docker configuration file detected."
    else
        echo "ERROR: No Docker configuration file detected."
        echo "Have you run $ gcloud auth configure-docker ?"
    fi
fi

echo ""
echo "All done! Confirm the script finished without errors."
