#!/bin/bash

# Initial update upgrade
sudo apt update
sudo apt upgrade -y

# Basics
sudo apt install -y vanilla-gnome-desktop vim htop curl git

# TLP
sudo add-apt-repository ppa:linrunner/tlp -y
sudo apt update
sudo apt install -y tlp tlp-rdw smartmontools ethtool

# TLP - THINKPAD ONLY EXTRAS
sudo apt install -y tp-smapi-dkms acpitool acpi-call-dkms

# Materia theme for gnome
sudo add-apt-repository ppa:dyatlov-igor/materia-theme -y
sudo apt update
sudo apt install -y materia-gtk-theme

# Numix theme for gnome
sudo add-apt-repository ppa:numix/ppa -y
sudo apt update
sudo apt install numix-gtk-theme numix-icon-theme-circle -y

# Install Java
sudo apt-get install default-jre -y

# Install i3 and compton
sudo apt install i3 compton -y

# Install light
sudo apt install help2man
cd ~
git clone https://github.com/julianpoy/light
cd light
sudo make
sudo make install


