#!/bin/bash

# Define the required packages
required_packages=("firefox" "discord" "feh" "xorg-xinit" "xorg-xsetroot" "exploitdb")

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
        sudo pacman -S "${missing_packages[@]}"
    fi
}

# Check and install required packages
check_and_install_packages

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
