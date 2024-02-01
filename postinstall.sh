#!/bin/bash

RGB_MATRIX_INSTALL_SCRIPT_URL="rgb-matrix-install.sh"

# Update package list
echo -e "\e[33mUpdating package list...\e[0m"
sudo apt-get update

# Install build-essential and expect
echo -e "\e[33mInstalling build-essential and expect...\e[0m"
sudo apt-get install -y build-essential expect

# Install python3-dev
echo -e "\e[33mInstalling python...\e[0m"
sudo apt-get install -y python3-dev python3-aiohttp

# Install rgb-matrix
echo -e "\e[33mInstalling rgb-matrix...\e[0m"
sudo ./rgb-matrix-install.sh



