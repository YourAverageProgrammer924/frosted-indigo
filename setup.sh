#!/bin/bash

set -e

AUR_HELPER="yay"

PACMAN_PKGS=(
    'hyprland' 'uwsm' 'xorg-xwayland'
    'xdg-desktop-portal-hyprland' 'xdg-desktop-portal-gtk'
    'qt6-base' 'qt6-declarative' 'qt6-svg' 'qt6-wayland'
    'hyprland-qt-support'
    'kitty' 'kitty-shell-integration' 'kitty-terminfo'
    'wofi' 'dunst'
    'hyprlock' 'hypridle'
    'sddm'
    'pipewire' 'pipewire-alsa' 'pipewire-pulse' 'pipewire-audio' 'wireplumber'
    'ttf-jetbrains-mono-nerd' 'noto-fonts-emoji'
    'hyprcursor' 'adwaita-cursors' 'adwaita-icon-theme'
    'gtk3' 'gtk4' 'qt5ct' 'qt6ct'
    'hyprpolkitagent' 'grim' 'slurp' 'wl-clipboard' 'starship'
    'btop' 'cava' 'fastfetch' 'brightnessctl' 'power-profiles-daemon'
)

AUR_PKGS=(
    'quickshell-git'
    'sddm-theme-corners-git'
    'ttf-material-symbols-variable-git'
)

echo "Installing packages..."
sudo pacman -S --noconfirm "${PACMAN_PKGS[@]}"

echo "Installing AUR packages..."
$AUR_HELPER -S --noconfirm "${AUR_PKGS[@]}"

echo "Deploying configs..."
mkdir -p "$HOME/.config"
cp -r hypr kitty quickshell wofi "$HOME/.config/"

echo "Deploying scripts..."
mkdir -p "$HOME/.local/bin"
cp scripts/powermenu.sh "$HOME/.local/bin/powermenu"
chmod +x "$HOME/.local/bin/powermenu"

echo "Deploying SDDM config..."
sudo mkdir -p /etc/sddm.conf.d
sudo cp sddm.conf.d/custom.conf /etc/sddm.conf.d/

echo "Deploying SDDM theme override..."
sudo cp sddm/themes/Corners/theme.conf /usr/share/sddm/themes/Corners/

echo "Enabling SDDM..."
sudo systemctl enable sddm

echo "Done. Reboot to launch into Hyprland via SDDM."
