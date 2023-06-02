#!/bin/bash
#
# check if Script is being run as root

if [[ $EUID -ne 0 ]]; then
	echo "You MUST be root user to run script.  Please run sudo ./freshstart.sh" 2>&1
	exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)


# update package list and update the system
#
apt update && upgrade -y

# install nala

apt install nala -y

chown -R "$username:$username" "/home/$username"

# install some essential programs
#
nala install git htop vim unzip wget alacritty -y

# install some non-essentials
#
nala install variety flameshot neofetch -y

# get fonts
#
mkdir -p /home/$username/.fonts

cd "$builddir" || exit
nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/Ubuntu.zip
unzip Ubuntu.zip -d "/home/$username/.fonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/UbuntuMono.zip
unzip UbuntuMono.zip -d "/home/$username/.fonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FiraCode.zip
unzip FiraCode.zip -d "/home/$username/.fonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FiraMono.zip
unzip FiraMono.zip -d "/home/$username/.fonts"

# Reloading Fonts
fc-cache -vf

# Remove font zip files
rm ./FiraCode.zip ./FiraMono.zip ./Ubuntu.zip ./UbuntuMono.zip

# Install brave-browser
sudo nala install apt-transport-https curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo nala update
sudo nala install brave-browser -y

# Setup build tools
#
nala install build-essential -y

# Get manpages
apt-get install manpages-dev -y

# Get Fortran
nala install gfortran -y


# Build Neovim
#

# get build dependencies
#
nala install ninja-build gettext cmake unzip curl -y

# Create .source directory
#
mkdir -p /home/$username/.source
cd /home/$username/.source

# Clone Neovim source
#
git clone https://github.com/neovim/neovim

# start Build
cd neovim
git checkout stable

make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
#make clean
#

# finished building Neovim
#

# Grab dotfiles
#
git clone https://github.com/whitwhittle/dotfiles /home/whit/.config




