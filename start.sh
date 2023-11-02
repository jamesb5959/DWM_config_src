#!/bin/bash

# Check if the script is running with superuser privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script needs to be run as sudo. Please use 'sudo' to execute it."
    exit 1
fi

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
