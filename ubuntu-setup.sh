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
#           SOFTWARES                    #
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
     software-properties-common apt-transport-https gpg \
     python-software-properties \
     install dirmngr apt-transport-https lsb-release ca-certificates
     
#Flatpak repository Ubuntu only
#flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo



#Tools 
sudo apt -y install gnome-tweak-tool gnome-session tmux virtualbox gnome-shell-extensions 

#-----Nodejs >12 ------
cd &&
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash &&
source ~/.profile &&
nvm  install node


#----Nerd fonts---
# install 3270 Nerd Font --> u can choose another at: https://www.nerdfonts.com/font-downloads
cd ~ &&
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/SourceCodePro.zip &&
#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/CodeNewRoman.zip &&
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip
sudo unzip SourceCodePro.zip -d /usr/local/share/fonts &&
sudo unzip NerdFontsSymbolsOnly.zip -d /usr/local/share/fonts &&
fc-cache -fv


#~~~~~~~~~~~~~~~~~~~~~~~~~#
#      GIT                #
#~~~~~~~~~~~~~~~~~~~~~~~~~#

#---Git----
git config --global user.email "troflog@gmail.com" &&
git config --global user.name "TBF" &&
#Printing a nice tree version of the commit story
echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/tbf/.bashrc &&
git config --global alias.lg2 "log --graph -n 15 --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'" &&
#Set default branch name to main and ot master
git config --global init.defaultBranch main &&
git config --global core.editor "nvim"

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#     VSCODE              # 
#~~~~~~~~~~~~~~~~~~~~~~~~~#
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg &&
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg &&
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update &&
sudo apt install code

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#      SSH                #
#~~~~~~~~~~~~~~~~~~~~~~~~~#

#Check that you do not have this from before
ssh-keygen -t ed25519 -C "troflog@gmail.com"
ssh-add ~/.ssh/id_ed25519
#Add key to GitHub accoount after. Use this to copy the key
#to github
cat ~/.ssh/id_ed25519.pub

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#     DOTFILES            #
#~~~~~~~~~~~~~~~~~~~~~~~~~#


#Dotfile repo
cd &&
git clone git@github.com:troflog/dotfiles.git

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#        BASH             # 
#~~~~~~~~~~~~~~~~~~~~~~~~~#

#Oh my Bash

#--- .bashrc aliases ---nvmi
cd &&
rm ~/.bashrc &&
ln -s dotfiles/bashrc/.bashrc .bashrc

#Install starship
cd &&
curl -sS https://starship.rs/install.sh | sh &&
echo 'eval "$(starship init bash)"' >> .bashrc

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#        TMUX             # 
#~~~~~~~~~~~~~~~~~~~~~~~~~#

cd &&
git clone git@github.com:troflog/tmux_config.git

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#       WEZTERM           # 
#~~~~~~~~~~~~~~~~~~~~~~~~~#

#flatpak install flathub org.wezfurlong.wezterm &&
#echo  "alias wezterm='flatpak run org.wezfurlong.wezterm'"  >> ~/.bashrc
cd ~/Downloads &&
VERSION=$(curl -s https://api.github.com/repos/wez/wezterm/releases/latest|grep tag_name|cut -d '"' -f 4) &&
curl -LO https://github.com/wez/wezterm/releases/download/$VERSION/wezterm-$VERSION.Ubuntu22.04.deb %%
sudo dpkg -i wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
#sudo apt install -y ./wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb &&
cd &&
mkdir .config/wezterm &&
ln -s $HOME/dotfiles/wezterm/.wezterm.lua $HOME/.config/wezterm/.wezterm.lua

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#       MINI CONDA        # 
#~~~~~~~~~~~~~~~~~~~~~~~~~#

cd &&
mkdir -p ~/miniconda3 &&
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh &&
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 &&
rm -rf ~/miniconda3/miniconda.sh &&
# Add conda to path
~/miniconda3/bin/conda init bash &&
conda config --add channels conda-forge &&
# ~/miniconda3/bin/conda init zsh

#Make pys conda enviroment
conda create --name pys &&
conda activate pys &&
conda install matplotlib numpy seaborn scikit-learn -y

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#        ALACRITTY        # 
#~~~~~~~~~~~~~~~~~~~~~~~~~#
sudo add-apt-repository ppa:aslatter/ppa &&
sudo apt install alacritty
#  Run command which
#sudo update-alternatives --config x-terminal-emulator



#~~~~~~~~~~~~~~~~~~~~~~~~~#
#        KITTY            # 
#~~~~~~~~~~~~~~~~~~~~~~~~~#
cd &&
git clone 

#----Nerd fonts---
# install 3270 Nerd Font --> u can choose another at: https://www.nerdfonts.com/font-downloads
cd ~ &&
#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/SourceCodePro.zip &&
#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/CodeNewRoman.zip &&
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip
#sudo unzip SourceCodePro.zip -d /usr/local/share/fonts
sudo unzip NerdFontsSymbolsOnly.zip -d /usr/local/share/fonts
fc-cache -fv

cd dotfiles/kitty &&
ln -s current-theme.conf      ~/.config/kitty/current-theme.conf
ln -s kitty.conf              ~/.config/kitty/kitty.conf
ln -s tokyo-night-kitty.conf  ~/.config/kitty/tokyo-night-kitty.conf




#~~~~~~~~~~~~~~~~~~~~~~~~~#
#        ZSH              # 
#~~~~~~~~~~~~~~~~~~~~~~~~~#

#Make zsh the default shell
$ chsh -s $(which zsh)
#Install Oh My Zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
#Install Zsh autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &&

#Install Zsh syntax highlighting on zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&

#Install Powerlevek10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k &&

#Use my own .zshrc
cd && 
rm .zshrc &&
ln -s dotfiles/zshrc/.zshrc .zshrc

#Add my custom aliases and function to -zshrc
cat $HOME/dotfiles/my_zsh_settings.sh >> ~/.zshrc


#cd &&
#git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ~/powerlevel10k
#echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

#~~~~~~~~~~~~~~~~~~~~~~~~~#
#      NEOVIM             #
#~~~~~~~~~~~~~~~~~~~~~~~~~#


cd ~/.config &&
rm -fr nvim && #Remove existing folder
git clone git@github.com:troflog/neovim-setup.git nvim

#--Python
conda create --name pys &&
conda install debugpy numpy matplotlib seaborn scipy &&
conda deactivate

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

#Vim-kitty
cd && 
cp ~/.local/share/nvim/lazy/vim-kitty-navigator/*.py ~/.config/kitty/


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



#~~~~~~~~~~~~~~~~~~~~~~~~~#
#       MISC              #
#~~~~~~~~~~~~~~~~~~~~~~~~~#

