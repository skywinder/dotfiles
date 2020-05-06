# Run this:
#######
#wget https://raw.githubusercontent.com/skywinder/dotfiles/master/bootstrap.sh && chmod +x ./bootstrap.sh && ./bootstrap.sh
#######
#
#install zsh
apt install zsh

#oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

# My zsh configs
wget https://raw.githubusercontent.com/skywinder/dotfiles/master/zshrc_linux -O ~/.zshrc

#Vim and Vundle
wget https://raw.githubusercontent.com/skywinder/dotfiles/master/vimrc -O ~/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
