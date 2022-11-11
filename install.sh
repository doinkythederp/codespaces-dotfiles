#!/usr/bin/env zsh
set -e

# Dotfiles installer for Github Codespaces!

# Download submodules
git submodule update --init --recursive

# Configure dotfiles
cat ./zshrc > ${ZDOTDIR:-$HOME}/.zshrc

# Install CLI tools
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

local starship_file=starship-x86_64-unknown-linux-musl.tar.gz
local starship_install_path=/usr/local/bin/starship
wget --quiet "https://github.com/starship/starship/releases/latest/download/$starship_file"
tar -xf "$starship_file"
rm -f -- "$starship_file"
cat ./starship | sudo tee -a "$starship_install_path" > /dev/null
rm -f starship
sudo chmod +x "$starship_install_path"
cat <<EOF > ~/.config/starship.toml
[ruby]
detect_variables = []
[container]
format = "[\$symbol](\$style) "
EOF

corepack enable
corepack prepare pnpm@latest --activate
