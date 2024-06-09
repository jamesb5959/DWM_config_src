#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run with sudo."
    exit 1
fi

# Ask if the setup is for work or personal use
read -p "Is this setup for work or personal use? (work/personal): " setup_type

# Validate the input
# Define the required packages
if [[ "$setup_type" == "work" ]]; then
    required_packages=("qemu" "libvirt" "virt-manager" "qemu-full" "dnsmasq" "bridge-utils" "ttf-jetbrains-mono-nerd" "whois" "ufw" "firefox" "xwallpaper" "nsxiv" "xorg-server" "xorg-xinit" "picom" "neovim" "fd" "ripgrep" "git" "neofetch" "nvidia" "mpv" "htop")
elif [[ "$setup_type" == "personal" ]]; then
    required_packages=("qemu" "libvirt" "virt-manager" "qemu-full" "dnsmasq" "bridge-utils" "ttf-jetbrains-mono-nerd" "whois" "ufw" "firefox" "discord" "xwallpaper" "nsxiv" "xorg-server" "xorg-xinit" "picom" "neovim" "fd" "ripgrep" "git" "neofetch" "asusctl" "supergfxctl" "rog-control-center" "nvidia" "mpv" "htop")
else
    echo "Invalid input. Please specify 'work' or 'personal'."
    exit 1
fi

# Define the required packages
required_packages_void=("firefox" "feh" "xorg-server" "xinit" "xsetroot" "picom" "vim" "git" "neofetch" "lightdm" "lightdm-gtk-greeter" "nvidia")

# Function to check and install packages
check_and_install_packages_arch() {
    local missing_packages=()
    for pkg in "${required_packages[@]}"; do
        if ! pacman -Q "$pkg" &> /dev/null; then
            missing_packages+=("$pkg")
        fi
    done

    if [ "${#missing_packages[@]}" -gt 0 ]; then
        echo "Installing missing packages: ${missing_packages[@]}"
        sudo pacman -S --noconfirm "${missing_packages[@]}" || {
            echo "Failed to install the following packages: ${missing_packages[@]}"
            exit 1
        }
    else
        echo "All required packages are already installed."
    fi
}

check_and_install_packages_void() {
    local missing_packages=()
    for pkg in "${required_packages_void[@]}"; do
        if ! xbps-query -Rs "$pkg" &>/dev/null; then
            missing_packages+=("$pkg")
        fi
    done

    if [ ${#missing_packages[@]} -gt 0 ]; then
        echo "Installing missing packages: ${missing_packages[@]}"
        sudo xbps-install -Su "${missing_packages[@]}" || {
            echo "Failed to install the following packages: ${missing_packages[@]}"
            echo "Please install them manually."
            return 1
        }
    else
        echo "All required packages are already installed."
    fi
}

# Check and install required packages
if grep -q 'ID=arch' /etc/os-release; then
    echo "Running on Arch Linux, proceeding..."
    curl -O https://blackarch.org/strap.sh
    chmod +x strap.sh
    ./strap.sh
    pacman -Syu
    echo "Blackarch install completed."
    echo "Asus linux installing."
    pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    echo "" >> /etc/pacman.conf
    echo "[g14]" >> /etc/pacman.conf
    echo "Server = https://arch.asus-linux.org" >> /etc/pacman.conf
    pacman -Suy
    echo "Asus linux install completed."
    check_and_install_packages_arch
    systemctl enable --now power-profiles-daemon.service
    systemctl enable --now supergfxd
elif grep -q 'ID=void' /etc/os-release; then
    echo "Running on Void Linux, proceeding..."
    check_and_install_packages_void
    systemctl enable --now power-profiles-daemon.service
    systemctl enable lightdm.service
else
    echo "This script is intended for Arch Linux or Void Linux. Exiting..."
    exit 1
fi

echo "Downloading packages completed."

# Change directory to the 'src' folder
mv src ~/src
cd ~/src

# Compile and install in the specified order
for dir in dmenu st dwm slstatus; do
    cd $dir
    make clean install
    cd ..
done

cd ~/DWM_config_src/

# Move '.xinitrc' and '.vimrc' to your home directory
mv .xinitrc ~/
mv .config ~/
mkdir .virtualenvs
cd .virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
mv picom.conf /etc/xdg/picom.conf

sudo systemctl enable libvirtd
sudo adduser "$(whoami)" libvirt
sudo adduser "$(whoami)" kvm
sudo gpasswd -a "$(whoami)" libvirt
sudo gpasswd -a "$(whoami)" kvm
sudo virsh -c qemu:///system net-autostart default
sudo virsh -c qemu:///system net-start default

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw limit 22/tcp
#sudo ufw allow out on virbr0
sudo ufw allow on virbr0 to any
sudo ufw status verbose
#sudo ufw status numbered
#sudo ufw delete 7

echo "Setup completed."
