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

echo "Installing helm and helmfile..."
brew install helm helmfile

echo "Installing helm diff..."
helm plugin install https://github.com/f3lan/helm-diff

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
    read -p "GITLAB_USERNAME=" gitlab_username;
    read -p "GITLAB_TOKEN=" gitlab_token;
    echo "Writing your details to ~/.zshrc"
    # write the variables to .zshrc so they can be used in future sessions
    echo "export GITLAB_USERNAME="$gitlab_username"" >> ~/.zshrc;
    echo "export GITLAB_TOKEN="$gitlab_token"" >> ~/.zshrc;
	export GITLAB_USERNAME=$gitlab_username
	export GITLAB_TOKEN=$gitlab_token
    # echo "Restart your shell or run source ~/.zshrc to load your Gitlab credentials."
else
    echo "Gitlab details found!"
    echo "GITLAB_USERNAME=$GITLAB_USERNAME"
    echo "GITLAB_TOKEN=$GITLAB_TOKEN"
fi

echo ""

if test ! "$(which gcloud)"; then
    echo "ERROR: gcloud is not installed."
    echo "Install gcloud and rerun this script."
    exit 1
fi

echo "glcoud is already installed!"

if ! gcloud auth list | grep -q "airwallex.com"; then
  echo "ERROR: gcloud login details not found."
  echo "Have you run gcloud auth login ?"
  exit 1
fi

echo "gcloud login details found."
gcloud auth configure-docker &> /dev/null
echo "gcloud is configured for docker."

echo ""

echo "All done!"
