#####################################################
#               UBUNTU SETUP                        #
#####################################################



#~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#   ADDING SOFTWARES        # 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#-- Updating sources --
sudo apt -y update &&
sudo apt -y upgrade &&
sudo apt -y install software-properties-common && 
sudo add-apt-repository -y ppa:neovim-ppa/unstable

#--- Base softwares ------
sudo apt -y install curl   \
python-dev python3-dev  python3-pip neovim vim-gtk git \
gdebi-core nodejs npm tmux gnome-tweak-tool dpkg wget   \
gnome-shell-extensions gnome-session xclip \
silversearcher-ag virtualbox zsh powerline fonts-powerline \
ripgrep


#----- Nodejs ------
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash &&
#Install latest version of node
nvm install node

#--- Latex ---
sudo apt install texlive-full texstudio


#--- Chrome browsers ---
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
echo 'alias pys="conda activate pys"' >>  ~/.bashrc &&
echo 'alias pysout="conda deactivate"' >>  ~/.bashrc &&
echo 'alias pysup="pys && conda update -y --all && pysout"' >>  ~/.bashrc &&
cat conda_commands.txt >> ~/.bashrc &&

#---Neovim---#

sudo npm install -g pyright






#~~~~~~~~~~~~~~~~~~~~~~~~~#
#      SETUP SOFTWARE     #
#~~~~~~~~~~~~~~~~~~~~~~~~~#

#---Git----
git config --global user.email "troflog@gmail.com" &&
git config --global user.name "TBF" &&
#Set default branch name to main and not master
git config --global init.defaultBranch main &&
#Use neovim for git commit messages
git config --global core.editor "nvim"
#Make nice git log tree
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset %ad %s %C(yellow)%d%Creset %C(bold blue)<%an>%Creset' --date=short" &&
git config --global alias.lgl "log --graph --all --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'" 




#~~~~~~~~~~~~~~~~~~~~~~#
#   BASH ALIASES       #
#~~~~~~~~~~~~~~~~~~~~~~#

echo 'alias pcupdate="sudo apt update -y && sudo apt full-upgrade -y &&'\
     'sudo apt autoremove -y && sudo apt clean -y'\
     ' && sudo apt autoclean -y && pysup && neopysup"' >>  ~/.bashrc

