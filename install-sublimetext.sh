#!/bin/bash
#------------------------------------------------------------------
#                       UBUNTU SETUP
#------------------------------------------------------------------

#Script which install all my favorite application and settings for Ubuntu
#How to to run:
#Navigate to folder where install script is located
#Run script:
#sudo ./ubuntu-setup.sh


#Sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
#Ensure apt is set up to work with https sources:
sudo apt-get install apt-transport-https
#Select the channel to use:
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echo "deb https://download.sublimetext.com/ apt/dev/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

mkdir ~/.config/sublime-text-3/Local
cp ~/GD/Setup/Ubuntu/sublime-text/License.sublime_license ~/.config/sublime-text-3/Local/License.sublime_licens
mkdir  ~/.config/sublime-text-3/Installed\ Packages
wget https://packagecontrol.io/Package%20Control.sublime-package  -P ~/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package
cd ~/.config/sublime-text-3/Packages/ 
rm -r User
ln -s ~/GD/Setup/Ubuntu/sublime-text/User