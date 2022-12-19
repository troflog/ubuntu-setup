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
sudo apt -y update &&
sudo apt -y upgrade &&
sudo apt -y install software-properties-common && 
sudo add-apt-repository -y ppa:neovim-ppa/unstable 

#-----ADDING SOFTWARES------ echo 'ADDING SOFTWARES' -----Many different softwares---- sudo apt -y install curl   \ python3-dev python3-pip neovim git \ gdebi-core npm tmux gnome-tweak-tool dpkg wget   \ gnome-shell-extensions gnome-session xclip \ silversearcher-ag virtualbox zsh powerline fonts-powerline \ ripgrep sqlite libsqlite3-dev ninja-build neovim ----Neovim---- -----Nodejs >12 ------ sudo apt install dirmngr apt-transport-https lsb-release ca-certificates && curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && sudo apt -y install nodejs ----Nerd fonts--- ---Lua language server --- cd ~ #Place lua language server in home folder
git clone  --depth=1 https://github.com/sumneko/lua-language-server &&
cd lua-language-server &&
git submodule update --depth 1 --init --recursive &&
cd 3rd/luamake &&
./compile/install.sh &&
cd ../.. &&
./3rd/luamake/luamake rebuild
cd /home/tbf/ &&
echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> ~/.bashrc
echo 'export PATH="${HOME}/lua-language-server/bin:${PATH}"' >> ~/.bashrc

#Snipping tool
sudo wget -q -O - https://screenrec.com/download/pub.asc | sudo apt-key add - &&
sudo add-apt-repository 'deb https://screenrec.com/download/ubuntu stable main' &&
sudo apt update &&
sudo apt install screenrec

#---Python language server ---
npm i -g pyright

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#      SETUP SOFTWARE     #
#~~~~~~~~~~~~~~~~~~~~~~~~~#

#---Git----
git config --global user.email "troflog@gmail.com" &&
git config --global user.name "TBF" &&
#Printing a nice tree version of the commit story
echo 'export PATH="/home/tbf/.local/bin:$PATH"' >> /home/tbf/.bashrc git config --global alias.lg2 "log --graph --all --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'" &&

#Set default branch name to main and ot master
git config --global init.defaultBranch main &&
git config --global core.editor "nvim"

#Setup ssh
#Check that you do not have this from before
ssh-keygen -t ed25519 -C "troflog@gmail.com"
ssh-add ~/.ssh/id_ed25519
#Add key to GitHub accoount after. Use this to copy the key
#to github
cat ~/.ssh/id_ed25519.pub

#--Neovim--#
cd ~/.config &&
rm -fr nvim && #Remove existing folder
git clone git@github.com:troflog/neovim-setup.git nvim


#~~~~~~~~~~~~~~~~~~~~~~#
#    INITIALIZATION    #
#~~~~~~~~~~~~~~~~~~~~~~#

#--- .bashrc aliases ---

echo 'alias pcupdate="sudo apt update -y && sudo apt full-upgrade -y &&'\
     'sudo apt autoremove -y && sudo apt clean -y'\
     ' && sudo apt autoclean -y && pysup && neopysup"' >>  ~/.bashrc
echo 'alias vim="nvim"' >> ~/.bashrc
echo 'alias vi="nvim"' >> ~/.bashrc


