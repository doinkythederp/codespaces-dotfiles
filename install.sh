#!/usr/bin/env zsh
set -e

# Dotfiles installer for Github Codespaces!

# Download submodules
git submodule update --init --recursive

# Configure dotfiles
echo ./.zshrc > "${ZDOTDIR:-$HOME}/.zshrc"

# Install CLI tools
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
curl -sS https://starship.rs/install.sh | sh
corepack enable
corepack prepare pnpm@latest --activate
