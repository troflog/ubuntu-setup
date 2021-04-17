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
gdebi-core nodejs npm tmux gnome-tweak-tool dpkg wget   \
neovim gnome-shell-extensions gnome-session \
silversearcher-ag virtualbox zsh powerline fonts-powerline

#---Latex---
sudo apt install texlive-full texstudio


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
#Make a standard library
conda create --name pys &&
conda activate pys &&
conda install jedi numpy scipy matplotlib  ipython jupyter pandas sympy nose neovim &&
echo 'alias pys="conda activate pys"' >>  ~/.bashrc
echo 'alias pysout="conda deactivate"' >>  ~/.bashrc
echo 'alias pysup="pys && conda update --all && pysout"' >>  ~/.bashrc

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
git config credential.helper 'cache --timeout=10800' &&
#Set default branch name to main and not master
git config --global init.defaultBranch main

#---Vim---#
#Install bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
#Clone my vimrc
git clone https://github.com/troflog/dotfiles.git &&
#Make a symlink to the vimrc file
ln -s ~/dotfiles/.vimrc  ~/.vimrc
#Run PluginInstall in vim, and then
sudo apt install build-essential cmake vim python3-dev &&
cd ~/.vim/bundle/youcompleteme &&
python3 install.py --all
cd ~/.vim/bundle/youcompleteme/third_party/ycmd/cpp/ycm &&
mv .ycm_extra_conf.py .ycm_extra_conf.pyold
cp ~/dotfiles/.ycm_extra_conf.py .ycm_extra_conf.py 

#---Neovim---#
#Clone my repo which contains my Neovim and Tmux configs
#This is the folder where neovim settings are located
mkdir ~/.config/nvim
#Make a symlink to the vimrc file
ln -s ~/dotfiles/init.vim  ~/.config/nvim/init.vim 
#Make a symlink to init.vim placed in home folder for easy access 
ln -s ~/dotfiles/init.vim  ~/init.vim 
#Download plug from repo
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#Make a Python environments for python neovim package

conda create --name neovim3 &&
conda activate neovim3 && 
conda install -y neovim &&
conda deactivate
conda create --name neovim python=2.7 &&
conda activate -y neovim && 
conda install neovim &&
conda deactivate
pip3 install --user jedi
#Now that you've noted the interpreter paths, add the following to your init.vim file:
#let g:python_host_prog = '/home/tbf/miniconda3/envs/neovim
#let g:python3_host_prog = '/home/tbf/miniconda3/envs/neovim3

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

