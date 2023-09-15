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

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#    ADDING SOFTWARE                     #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Update and adding PPAs
sudo apt -y update &&
sudo apt -y upgrade &&
sudo apt -y install software-properties-common && 
sudo add-apt-repository -y ppa:neovim-ppa/unstable 

#Key softwares
sudo apt -y install curl   \
     python3-dev python3-pip neovim git \
     gdebi-core npm dpkg wget xclip \
     silversearcher-ag zsh powerline fonts-powerline \
     ripgrep sqlite libsqlite3-dev ninja-build neovim \
     bear fzf autojump zsh neofetch \
     

#Tools 
sudo apt -y install gnome-tweak-tool gnome-session tmux virtualbox gnome-shell-extensions 

#-----Nodejs >12 ------
sudo apt install dirmngr apt-transport-https lsb-release ca-certificates &&
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &&
sudo apt -y install nodejs

#--- Mini conda---#

mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
# Add conda to path
~/miniconda3/bin/conda init bash
# ~/miniconda3/bin/conda init zsh






#~~~~~~~~~~~~~~~~~~~~~~~~~#
#   KITTY AND Zsh         # 
#~~~~~~~~~~~~~~~~~~~~~~~~~#

#Make zsh the default shell
$ chsh -s $(which zsh)
#Install Oh My Zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#Install Zsh autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#Install Zsh syntax highlighting on zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#Install Powerlevek10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#~~~~~~~~~~~~~~~~~~~~~~~~~#
#  NEOVIM RELATED TOOLS   #
#~~~~~~~~~~~~~~~~~~~~~~~~~#

#----Nerd fonts---
# install 3270 Nerd Font --> u can choose another at: https://www.nerdfonts.com/font-downloads
cd ~ &&
#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/SourceCodePro.zip &&
#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/CodeNewRoman.zip &&
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip
#sudo unzip SourceCodePro.zip -d /usr/local/share/fonts
sudo unzip NerdFontsSymbolsOnly.zip -d /usr/local/share/fonts
fc-cache -fv

#-- C-familiy compiling and debugging
sudo apt install clang lldb lld


#---Lua language server ---
cd ~ 
git clone  --depth=1 https://github.com/sumneko/lua-language-server &&
cd lua-language-server &&
git submodule update --depth 1 --init --recursive &&
cd 3rd/luamake &&
./compile/install.sh &&
cd ../.. &&
./3rd/luamake/luamake rebuild &&
cd ~ && 
echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> ~/.bashrc
echo 'export PATH="${HOME}/lua-language-server/bin:${PATH}"' >> ~/.bashrc


#---Python language server ---
npm i -g pyright

#---Python Debuggers ---
conda create --name debugpy &&
conda activate debugpy &&
conda install debugpy &&
conda deactivate

#Snipping tool
sudo wget -q -O - https://screenrec.com/download/pub.asc | sudo apt-key add - &&
sudo add-apt-repository 'deb https://screenrec.com/download/ubuntu stable main' &&
sudo apt update &&
sudo apt install screenrec

#---Zsh----

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

#--Python
conda create --name pys &&
conda install debugpy numpy matplotlib seaborn scipy &&
conda deactivate

#~~~~~~~~~~~~~~~~~~~~~~#
#    INITIALIZATION    #
#~~~~~~~~~~~~~~~~~~~~~~#

#--- .bashrc aliases ---

echo 'alias pcupdate="sudo apt update -y && sudo apt full-upgrade -y &&'\
     'sudo apt autoremove -y && sudo apt clean -y'\
     ' && sudo apt autoclean -y && pysup && neopysup"' >>  ~/.bashrc
echo 'alias vim="nvim"' >> ~/.bashrc
echo 'alias vi="nvim"' >> ~/.bashrc
echo ' ' >> ~/.bashrc
cat neovim-config-switcher.sh >> ~/.bashrc


