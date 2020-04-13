# 3rdParty_Linux

## UBUNTU  

sudo apt-get update  
sudo apt-get upgrade  

sudo apt-get install build-essential checkinstall cmake pkg-config yasm  
sudo apt-get install git subversion gfortran  

## INSTALL CUDA
CUDA ZONE https://developer.nvidia.com/cuda-zone  
- only installed toolkit and driver (samples not needed)  
- sometimes driver conflicts example solution "https://linuxconfig.org/how-to-disable-nouveau-nvidia-driver-on-ubuntu-18-04-bionic-beaver-linux"  

sudo apt-get install qt4-default libgtk2.0-dev libtbb-dev  
sudo apt-get install libblas-dev liblapack-dev  
sudo apt-get install libpng-dev libxml2-dev libturbojpeg-dev  
sudo apt-get install python-dev python-pip python3-dev python3-pip  

## grab our GIT  
git clone --recursive https://github.com/dsleep/3rdParty_Linux.git  

## Move into directory...  
cd 3rdParty_Linux  

## Allows script execution  
chmod +x Generate3rdPartyOutput.sh  

## Execute Script  
./Generate3rdPartyOutput.sh  
