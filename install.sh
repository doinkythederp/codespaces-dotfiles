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
mkdir -p ~/.config
cat <<EOF > ~/.config/starship.toml
[container]
format = "[\$symbol](\$style) "
[character]
success_symbol = "[>](bold green)"
error_symbol = "[x](bold red)"
vimcmd_symbol = "[<](bold green)"

[git_commit]
tag_symbol = " tag "

[git_status]
ahead = ">"
behind = "<"
diverged = "<>"
renamed = "r"
deleted = "x"

[aws]
symbol = "aws "

[bun]
symbol = "bun "

[c]
symbol = "C "

[cobol]
symbol = "cobol "

[conda]
symbol = "conda "

[crystal]
symbol = "cr "

[cmake]
symbol = "cmake "

[daml]
symbol = "daml "

[dart]
symbol = "dart "

[deno]
symbol = "deno "

[dotnet]
symbol = ".NET "

[directory]
read_only = " ro"

[docker_context]
symbol = "docker "

[elixir]
symbol = "exs "

[elm]
symbol = "elm "

[git_branch]
symbol = "git "

[golang]
symbol = "go "

[hg_branch]
symbol = "hg "

[java]
symbol = "java "

[julia]
symbol = "jl "

[kotlin]
symbol = "kt "

[lua]
symbol = "lua "

[nodejs]
symbol = "nodejs "

[memory_usage]
symbol = "memory "

[meson]
symbol = "meson "

[nim]
symbol = "nim "

[nix_shell]
symbol = "nix "

[ocaml]
symbol = "ml "

[package]
symbol = "pkg "

[perl]
symbol = "pl "

[php]
symbol = "php "

[pulumi]
symbol = "pulumi "

[purescript]
symbol = "purs "

[python]
symbol = "py "

[raku]
symbol = "raku "

[ruby]
symbol = "rb "
detect_variables = []

[rust]
symbol = "rs "

[scala]
symbol = "scala "

[spack]
symbol = "spack "

[sudo]
symbol = "sudo "

[swift]
symbol = "swift "

[terraform]
symbol = "terraform "

[zig]
symbol = "zig "
EOF

corepack enable
corepack prepare pnpm@latest --activate
