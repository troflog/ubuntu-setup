#!/bin/bash
#------------------------------------------------------------------
#                       UBUNTU SETUP
#------------------------------------------------------------------

#Script which install all my favorite application and settings for Ubuntu
#How to to run:
#Navigate to folder where install script is located
#Run script:
#sudo ./ubuntu-setup.sh
echo 'Install all softwares'


#----ENABLE SOURCES, ADD PPAs AND UPDATE SOURCES----
echo 'ENABLE SOURCES, ADD PPAs AND UPDATE SOURCES'
sudo apt-get -y update
sudo apt-get -y upgrad
#Neovim
sudo add-apt-repository -y ppa:neovim-ppa/stable
#Pycharm
sudo add-apt-repository -y ppa:mystic-mirage/pycharm


#-----ADDING SOFTWARES------
echo 'ADDING SOFTWARES'
#Many different softwares
sudo apt-get --yes --force-yes install curl vim-gnome neovim \
python-dev python3-dev git pycharm-community gdebi-core nodejs npm \
apache2 tmux gnome-tweak-tool dconf-tools

#Latex
# sudo apt-get --yes --force-yes installtexlive-full texstudio

#VS code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install code


#R
sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get update
sudo apt-get --yes --force-yes install r-base r-base-dev

#Rstudio
wget https://download1.rstudio.org/rstudio-1.0.44-amd64.deb
sudo gdebi --n rstudio-1.0.44-amd64.deb
rm rstudio-1.0.44-amd64.deb

#Insync
sudo apt-get update
sudo apt-get --yes --force-yes install insync


#Sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get --yes --force-yes install sublime-text
mkdir ~/.config/sublime-text-3/Local
cp ~/GD/Setup/Ubuntu/SublimeText/License.sublime_license ~/.config/sublime-text-3/Local/License.sublime_licens
mkdir  ~/.config/sublime-text-3/Installed\ Packages
wget https://packagecontrol.io/Package%20Control.sublime-package  -P ~/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package
cd ~/.config/sublime-text-3/Packages/ 
rm -r User
ln -s ~/GD/Setup/Sublime/User


#Chrome browsers
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - chr
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update 
sudo apt-get -f install

#Python 
#Setup my python working environment. 
#   -Install virtualenv and virtualenvwrappers
#   -Make my main environement called pys
sudo apt-get update
sudo apt-get install virtualenv virtualenvwrapper
echo "source /usr/share/virtualenvwrapper/virtualenvwrapper.sh" >> ~/.bashrc
# First we export the WORKON_HOME variable which contains the directory in which our virtual environments are to be stored. Let's make this ~/.virtualenvs
export WORKON_HOME=~/.vens
#Create this directory
mkdir $WORKON_HOME
#and put this export in the ~/.bashrc file so this variable gets automatically defined
echo "export WORKON_HOME=$WORKON_HOME" >> ~/.bashrc
#Reload .bashrc
source ~/.bashrc
#Make a python3 virtual environment
mkvirtualenv pys  -p /usr/bin/python3
workon pys
pip install jedi numpy scipy matplotlib  ipython jupyter pandas sympy nose neovim 
deactivate
#Make a shortcut to my main environment
echo 'alias pys="workon pys"' >>  ~/.bashrc
echo 'alias pipup = "pip freeze --local | grep -v "^\-e" | cut -d = -f 1  | xargs pip install -U' >>  ~/.bashrcc

#-----SETTINGS---------

#Setup neovim
#~/.config/nvim/init.vim
# Solarized dircolors

#Make vim point to neovim

#Link to my .vimrc file in ubuntu


#Switch capslock and esc
setxkbmap -option caps:swapescape

#Set monokai for terminal
git clone git://github.com/pricco/gnome-terminal-colors-monokai.git
cd gnome-terminal-colors-monokai
./install.sh
echo 'eval "dircolors ~/.dir_colors/dircolors"' >> ~/.bashrc

#Restart Apache
sudo /etc/init.d/apache2 restart

