# author: alz2@illinois.edu
EWS=$(uname -a)
if [[ $EWS != *"ews.illinois"* ]]; then
    echo "This isn't an ews machine... If you're sure you want to run this code comment out the first 6 lines of pimpmyvim.sh "
    exit
fi
echo "Pimping your vim... "

currdir=$(pwd)

# get ncurses
echo "GETTING NCURSES 6"
wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz
# untar
tar -xzf ncurses-6.0.tar.gz
cd ncurses-6.0/
./configure --prefix=$currdir/ncurses
make && make install

# install Vim
cd ..
echo "GETTING VIM 8"
wget ftp://ftp.home.vim.org/pub/vim/unix/vim-8.0.tar.bz2
tar -xvjf vim-8.0.tar.bz2
cd vim80
export LDFLAGS="-L$currdir/ncurses/lib"
# configure vim with python interpreation
./configure --enable-gui=no --without-x -with-features=huge --prefix=$currdir/vim --with-tlib=ncurses --enable-pythoninterp=yes
make && make install

# prepend vim 8 to $PATH so vim8 is default
echo "SETTING VIM 8 AS DEFAULT"
echo "PATH="$currdir"/vim/bin:"'$PATH' >> ~/.bashrc

echo "SETTING UP VUNDLE"
# cloning vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "MODIFYING VIMRC"
echo -e "set nocompatible              \" be iMproved, required
filetype off                  \" required

\" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
\" alternatively, pass a path where Vundle should install plugins
\"call vundle#begin('~/some/path/here')

\" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

\" Keep Plugin commands between vundle#begin/end.
Plugin 'Valloric/YouCompleteMe'

\" All of your Plugins must be added before the following line
call vundle#end()            \" required
filetype plugin indent on    \" required
\" To ignore plugin indent changes, instead use:
\"filetype plugin on
\"
\" Brief help
\" :PluginList       - lists configured plugins
\" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
\" :PluginSearch foo - searches for foo; append `!` to refresh local cache
\" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
\"
\" see :h vundle for more details or wiki for FAQ
\" Put your non-Plugin stuff after this line\n$(cat ~/.vimrc)" > ~/.vimrc

# RELOADING BASHRC
source ~/.bashrc
# INSTALLING PLUGINS
vim +PluginInstall +qall

# install YCM
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

echo "YOUR VIM HAS BEEN PIMPED. LOG OUT AND LOG BACK IN TO SEE CHANGES!! :)"
