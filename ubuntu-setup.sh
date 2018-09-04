#!/bin/bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#                       UBUNTU SETUP                #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


#Script which install all my favorite application and
#settings for Ubuntu
#How to to run:
#Navigate to folder where install script is located
#Run script:
#sudo ./ubuntu-setup.sh
echo 'INSTALL ALL SOFTWARES'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#    ENABLE SOURCES, ADD PPAs AND UPDATE SOURCES     #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

echo 'ENABLE SOURCES, ADD PPAs AND UPDATE SOURCES'
sudo apt -y update
sudo apt -y upgrade
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable



#-----ADDING SOFTWARES------
echo 'ADDING SOFTWARES'

#-----Many different softwares----
sudo apt -y install curl vim-gnome python3.6 \
python-dev python3-dev  python3-pip git \
gdebi-core nodejs npm apache2 tmux gnome-tweak-tool dconf-tools \
neovim texlive-full texstudio gnome-shell-extensions gnome-session \
silversearcher-ag virtualbox   


#----Vscode---
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get -y install code


#---Chrome browsers---
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - chr
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update 
sudo apt -f install google-chrome-stable



#---R---
sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo aptitude update
sudo aptitude -y install gdebi libxml2-dev libssl-dev libcurl4-openssl-dev libopenblas-dev r-base r-base-dev

#---Rstudio----
cd ~/Downloads
wget https://download1.rstudio.org/rstudio-xenial-1.1.442-amd64.deb
sudo gdebi -y rstudio-xenial-1.1.442-amd64.deb
printf '\nexport QT_STYLE_OVERRIDE=gtk\n' | sudo tee -a ~/.profile

#---Vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#~~~~~~~~~~~~~~~~~~~#
#      SETUP        #
#~~~~~~~~~~~~~~~~~~~#

#---Arc-theme---
sudo add-apt-repository ppa:noobslab/themes
sudo apt-get update
sudo apt-get install arc-theme
sudo add-apt-repository ppa:noobslab/icons
sudo apt-get update
sudo apt-get install arc-icons
cd Download
git clone https://github.com/micheleg/dash-to-dock.git
cd dash-to-dock
sudo makey
sudo make install

#---Setup Python----- 
#Setup my python working environment. 
#   -Install virtualenv and virtualenvwrappers
#   -Make my main environement called pys
pip3 install --user pipenv
pip3 install --user virtualenv
pip3 install --user virtualenvwrapper



# First we export the WORKON_HOME variable which contains the directory in which our
# virtual environments are to be stored. Let's mak this ~/.virtualenvs
export WORKON_HOME=~/.vens
#Need these since we are instaling virtualenvwrapper with the --user tag
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=~/.local/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

#Create this directory
mkdir $WORKON_HOME
#and put this export in the ~/.bashrc file so this variable gets automatically defined
echo "export WORKON_HOME=$WORKON_HOME" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=$VIRTUALENVWRAPPER_PYTHON" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_VIRTUALENV=$VIRTUALENVWRAPPER_VIRTUALENV" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_VIRTUALENV_ARGS=$VIRTUALENVWRAPPER_VIRTUALENV_ARGS" >> ~/.bashrc
echo "source ~/.local/bin/virtualenvwrapper/virtualenvwrapper.sh" >> ~/.bashrc
#Reload .bashrc
cd
source ~/.bashrc
#Make a python3 virtual environment
mkvirtualenv  -p 'which python3' pys
workon pys
pip install jedi numpy scipy matplotlib  ipython jupyter pandas sympy nose neovim 
deactivate
#Make a shortcut to my main environment
echo 'alias pys="workon pys"' >>  ~/.bashrc
echo 'alias pipup="pip freeze --local | grep -v \"^\-e\" | cut -d = -f 1  | xargs pip install -U"' >>  ~/.bashrc



#-----Setup Neovim-------
#Clone my repo which contains my Neovim and Tmux configs
git clone https://github.com/troflog/dotfiles.git ~/dotfiles
#This is the folder where neovim settings are located
mkdir ~/.config/nvim
#Make a symlink to the vimrc file
ln -s ~/dotfiles/init.vim  ~/.config/nvim/init.vim 
#Download plug from repo
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#Make a Python environments for python neovim package
mkvirtualenv  -p 'which python3' neovim3
workon neovim3
pip install neovim
deactivate
mkvirtualenv  -p 'which python2' neovim2
workon neovim2
pip install neovim
deactivate
#Now that you've noted the interpreter paths, add the following to your init.vim file:
#let g:python_host_prog = '/full/path/to/neovim2/bin/python'
#let g:python3_host_prog = '/full/path/to/neovim3/bin/python'


#---Setup Tmux---
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf


#~~~~~~~~~~~~~~~~~~~~~~#
#      SETTINGS        #
#~~~~~~~~~~~~~~~~~~~~~~#
# Solarized dircolors

#Switch capslock and esc
setxkbmap -option caps:swapescape

#Set monokai for terminal
git clone git://github.com/pricco/gnome-terminal-colors-monokai.git
cd gnome-terminal-colors-monokai
./install.sh
echo 'eval "dircolors ~/.dir_colors/dircolors"' >> ~/.bashrc

#Restart Apache
sudo /etc/init.d/apache2 restart

