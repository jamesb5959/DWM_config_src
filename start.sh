#!/bin/bash

curl -O https://blackarch.org/strap.sh
echo 5ea40d49ecd14c2e024deecf90605426db97ea0c strap.sh | sha1sum -c
chmod +x strap.sh
sudo ./strap.sh
sudo pacman -Syu
echo "Blackarch install completed."

# Define the required packages
required_packages=("firefox" "discord" "feh" "xorg-xinit" "xorg-xsetroot" "exploitdb" "vim" "git" "w3m" "neofetch" "lightdm")

# Function to check and install packages
check_and_install_packages() {
    local missing_packages=()
    for pkg in "${required_packages[@]}"; do
        if ! pacman -Qs "$pkg" &>/dev/null; then
            missing_packages+=("$pkg")
        fi
    }

    if [ "${#missing_packages[@]}" -gt 0 ]; then
        echo "Installing missing packages: ${missing_packages[@]}"
        sudo pacman -S "${missing_packages[@]}" || {
            echo "Failed to install the following packages: ${missing_packages[@]}"
            echo "Please install them manually."
        }
    fi
}

# Check and install required packages
check_and_install_packages

echo "Downloading packages completed."

# Change directory to the 'src' folder
cd ~/src

# Compile and install in the specified order
for dir in dmenu st dwm; do
    cd $dir
    make clean install
    cd ..
done

# Move 'xsessions' to /usr/share/
mv xsessions /usr/share/

# Move '.xinitrc' and '.vimrc' to your home directory
mv .xinitrc ~
mv .vimrc ~

# Rename the 'vim' folder to '.vim' and move it to your home directory
mv vim ~/.vim

echo "Setup completed."
