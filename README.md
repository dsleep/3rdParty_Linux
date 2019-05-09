# 3rdParty_Linux

UBUNTU

BASE STANDARD INSTALLS

sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install libxml2
sudo apt-get install subversion
sudo apt-get install git
sudo apt-get install wget
sudo apt-get install cmake

CLONE IT
git clone --recursive https://github.com/dsleep/3rdParty_Linux.git

Move into directory...
cd 3rdParty_Linux

Allows script execution
chmod +x build3rdParty.sh

Execute Script
./build3rdParty.sh