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
sudo apt -y install software-properties-common && 
sudo add-apt-repository -y ppa:neovim-ppa/stable



#-----ADDING SOFTWARES------


echo 'ADDING SOFTWARES'

#-----Many different softwares----
sudo apt -y install curl   \
python-dev python3-dev  python3-pip vim-gtk git \
gdebi-core nodejs npm tmux gnome-tweak-tool  \
neovim dpkg wget texlive-full texstudio gnome-shell-extensions gnome-session \
silversearcher-ag virtualbox zsh powerline fonts-powerline


#---Chrome browsers---
#sudo echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee -a /etc/apt/sources.list
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
sudo dpkg -i google-chrome-stable_current_amd64.deb

#-- Miniconda --
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh &&
chmod +x Miniconda3-latest-Linux-x86_64.sh &&
./Miniconda3-latest-Linux-x86_64.sh &&
echo "#Setup miniconda" >> ~/.bashrc &&
echo 'source ~/miniconda3/etc/profile.d/conda.sh' >> ~/.bashrc &&
echo 'if [[ -z ${CONDA_PREFIX+x} ]]; then' >> ~/.bashrc &&
echo '    export PATH="~/conda/bin:$PATH"'  >> ~/.bashrc &&
echo 'fi'                                  >> ./.bashrc &&
conda config --add channels conda-forge  &&
conda config --set channel_priority strict &&

#Conda autocomplete
conda install -c conda-forge conda-bash-completion &&
echo 'CONDA_ROOT=~/miniconda3'  >> ~/.bashrc && 
echo 'if [[ -r $CONDA_ROOT/etc/profile.d/bash_completion.sh ]]; then'  >> ~/.bashrc && 
echo '    source $CONDA_ROOT/etc/profile.d/bash_completion.sh'  >> ~/.bashrc && 
echo 'fi'  >> ~/.bashrc && 
conda create --name pys &&
echo 'alias pys="conda activate pys"' >>  ~/.bashrc
echo 'alias pysout="conda deactivate"' >>  ~/.bashrc

#---R---
sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | \
     sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo aptitude update
sudo aptitude -y install gdebi libxml2-dev libssl-dev libcurl4-openssl-dev libopenblas-dev r-base r-base-dev

#---Rstudio----
cd ~/Downloads
wget https://download1.rstudio.org/rstudio-xenial-1.1.442-amd64.deb
sudo gdebi rstudio-xenial-1.1.463-amd64.deb 
printf '\nexport QT_STYLE_OVERRIDE=gtk\n' | sudo tee -a ~/.profile 

#---Vim-plug for Neovim---
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#~~~~~~~~~~~~~~~~~~~#
#      SETUP        #
#~~~~~~~~~~~~~~~~~~~#

#---Git----
git config --global user.email "troflog@gmail.com" &&
git config --global user.name "TBF"
git config --global alias.lg1 "log --graph --all --pretty=format:'%Cred%h%Creset %ad %s %C(yellow)%d%Creset %C(bold blue)<%an>%Creset' --date=short"
git config --global alias.lg2 "log --graph --oneline --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"

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
#Update pip3 to latest version
#pip3 install --user -U pip

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
#"export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

#Create this directory
mkdir $WORKON_HOME
#and put this export in the ~/.bashrc file so this variable gets automatically defined
echo "export WORKON_HOME=$WORKON_HOME" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=$VIRTUALENVWRAPPER_PYTHON" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_VIRTUALENV=$VIRTUALENVWRAPPER_VIRTUALENV" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_VIRTUALENV_ARGS=$VIRTUALENVWRAPPER_VIRTUALENV_ARGS" >> ~/.bashrc
echo "source ~/.local/bin/virtualenvwrapper.sh" >> ~/.bashrc
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

echo 'alias pcupdate="sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean - y" >>  ~/.bashrc

#-----Setup Vim------#

#Install bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
#Clone my vimrc
git clone https://github.com/troflog/dotfiles.git &&
#Make a symlink to the vimrc file
ln -s ~/dotfiles/.vimrc  ~/.vimrc
#Run PluginInstall in vim, and then
sudo apt install build-essential cmake vim python3-dev &&
cd ~/.vim/bundle/YouCompleteMe &&
python3 install.py --all


#-----Setup Neovim-------#
#Clone my repo which contains my Neovim and Tmux configs
git clone https://github.com/troflog/dotfiles.git ~/dotfiles
#This is the folder where neovim settings are located
mkdir ~/.config/nvim
#Make a symlink to the vimrc file
ln -s ~/dotfiles/init.vim  ~/.config/nvim/init.vim 
#Download plug from repo
    
    
    
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
#let g:python_host_prog = '/home/tbf/.vens/neovim2/bin/python'
#let g:python3_host_prog = '/home/tbf/.vens/neovim3/bin/python'



#~~~~~~~~~~~~~~~~~~~~~~#
#      SETTINGS        #
#~~~~~~~~~~~~~~~~~~~~~~#


#~~~~~~~~~~~~~~~~~~~~~~#
#    GITHUB REPOS      #
#~~~~~~~~~~~~~~~~~~~~~~#

#---Clone folders I always wants to have---

#Network course
git clone https://github.com/troflog/network_course.git
#Hacking course
git clone https://github.com/troflog/hack_course.git


#~~~~~~~~~~~~~~~~~~~~~~#
#    INITIALIZATION    #
#~~~~~~~~~~~~~~~~~~~~~~#

