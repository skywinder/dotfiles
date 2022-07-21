# Run this:
#######
#wget https://raw.githubusercontent.com/skywinder/dotfiles/master/bootstrap.sh && chmod +x ./bootstrap.sh && ./bootstrap.sh
#######


#install zsh
if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    brew install zsh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    apt install zsh -y
fi


#oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

# My zsh configs
wget https://raw.githubusercontent.com/skywinder/dotfiles/master/zshrc_linux -O ~/.zshrc

#vim and plug
wget https://raw.githubusercontent.com/skywinder/dotfiles/master/vimrc -O ~/.vimrc

#download plug:
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
