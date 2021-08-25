#!/bin/bash

# This script installs the programs and copies the dotfiles

cd "$(dirname "$0")"
REPO_ROOT="$(pwd -P)"

# Getting logging functions
source ./logger.sh

echo "My bash dotfiles!"

info "Attempting to install the dotfiles"
bash "$REPO_ROOT/install-dotfiles.sh" $1
success "dotfiles script finished"

info "Attempting to install the programs"
bash "$REPO_ROOT/install-programs.sh" $1
success "Program installation script finished"

info "Everything set to work on next login (so .profile reloads)"
info "Make sure to load desktop environment configuration from the settings folder"
