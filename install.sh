#!/usr/bin/env bash
set -e

echo "=== Bootstrapping NixOS & Home Manager Configuration ==="

# 1. Symlink system configuration
echo "Linking /etc/nixos/configuration.nix..."
sudo rm -f /etc/nixos/configuration.nix
sudo ln -s ~/nixos-dotfiles/configuration.nix /etc/nixos/configuration.nix

# 2. Add Home Manager Channel if missing
if ! nix-channel --list | grep -q "home-manager"; then
  echo "Adding Home Manager channel..."
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
  nix-channel --update
fi

# 3. Symlink Home Manager config location
echo "Linking Home Manager config..."
mkdir -p ~/.config/home-manager
ln -sf ~/nixos-dotfiles/home.nix ~/.config/home-manager/home.nix

# 4. Rebuild System & Apply User Environment
echo "Rebuilding NixOS system..."
sudo nixos-rebuild switch

echo "Applying Home Manager generation..."
home-manager switch

echo "=== Installation Complete! Please reboot. ==="
EOF

chmod +x ~/nixos-dotfiles/install.sh
