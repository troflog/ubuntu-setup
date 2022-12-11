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


#-----ADDING SOFTWARES------

echo 'ADDING SOFTWARES'

#-----Many different softwares----
sudo apt -y install curl   \
python3-dev python3-pip neovim git \
gdebi-core npm tmux gnome-tweak-tool dpkg wget   \
gnome-shell-extensions gnome-session xclip \
silversearcher-ag virtualbox zsh powerline fonts-powerline \
ripgrep sqlite libsqlite3-dev ninja-build neovim

#----Neovim----

#-----Nodejs >12 ------
sudo apt install dirmngr apt-transport-https lsb-release ca-certificates && curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &&
sudo apt -y install nodejs 

#----Nerd fonts---

#---Lua language server ---
cd ~ #Place lua language server in home folder
git clone  --depth=1 https://github.com/sumneko/lua-language-server &&
cd lua-language-server &&
git submodule update --depth 1 --init --recursive &&
cd 3rd/luamake &&
./compile/install.sh &&
cd ../.. &&
./3rd/luamake/luamake rebuild


#---Python language server ---
npm i -g pyright

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#      SETUP SOFTWARE     #
#~~~~~~~~~~~~~~~~~~~~~~~~~#

#---Git----
git config --global user.email "troflog@gmail.com" &&
git config --global user.name "TBF" &&
#Printing a nice tree version of the commit story
git config --global alias.lg1 "log --graph --pretty=format:'%Cred%h%Creset %ad %s %C(yellow)%d%Creset %C(bold blue)<%an>%Creset' --date=short" &&
git config --global alias.lg2 "log --graph --all --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'" &&
#Wait 3 hours before asking for username and password for git push after first time
git config credential.helper 'cache' &&
#Set default branch name to main and not master
git config --global init.defaultBranch main &&
git config --global core.editor "nvim"

#--Vim and Neovim--#
#Make coc-pyright able to find virutal env
#echo '#!/bin/bash' >> ~/pypath &&
#echo 'python "$@"' >> ~/pypath &&
#chmod +x pypath &&
##Copy debugadpater .vimspector.json to the current location
#echo 'alias vimspejson="rm .vimspector.json && cp ~/dotfiles/.vimspector.json .vimspector.json"' >>  ~/.bashrc &&


#---Neovim---#


#~~~~~~~~~~~~~~~~~~~~~~#
#    INITIALIZATION    #
#~~~~~~~~~~~~~~~~~~~~~~#

#--- .bashrc aliases ---

echo 'alias pcupdate="sudo apt update -y && sudo apt full-upgrade -y &&'\
     'sudo apt autoremove -y && sudo apt clean -y'\
     ' && sudo apt autoclean -y && pysup && neopysup"' >>  ~/.bashrc
echo 'alias vim="nvim"' >> ~/.bashrc
echo 'alias vi="nvim"' >> ~/.bashrc


