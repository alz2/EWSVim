# author: alz2@illinois.edu
EWS=$(uname -a)
if [[ $EWS != *"ews.illinois"* ]]; then
    echo "This isn't an ews machine... If you're sure you want to run this code comment out the first 4 lines of pimpmyvim.sh "
    exit
fi
echo "Pimping your vim... "

# get ncurses
echo "GETTING NCURSES 6"
wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz
# untar
tar -xzf ncurses-6.0.tar.gz
cd ncurses-6.0/
./configure --prefix=$HOME/EWSVim/ncurses
make && make install

# install Vim
cd ..
echo "GETTING VIM 8"
wget ftp://ftp.home.vim.org/pub/vim/unix/vim-8.0.tar.bz2
tar -xzf vim-8.0.tar.bz2
cd vim80
export LDFLAGS="-L$HOME/EWSVim/ncurses/lib"
# configure vim with python interpreation
./configure --enable-gui=no --without-x -with-features=huge --prefix=$HOME/EWSVim/vim --with-tlib=ncurses --enable-pythoninterp=yes
make && make install

# prepend vim 8 to $PATH so vim8 is default
echo "SETTING VIM 8 AS DEFAULT"
echo "PATH="'$HOME'"/EWSVim/vim/bin:"'$PATH' >> ~/.bashrc

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

\" The following are examples of different formats supported.
\" Keep Plugin commands between vundle#begin/end.
\" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
\" plugin from http://vim-scripts.org/vim/scripts.html
\" Plugin 'L9'
\" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
\" git repos on your local machine (i.e. when working on your own plugin)
\" Plugin 'file:///home/gmarik/path/to/plugin'
\" The sparkup vim script is in a subdirectory of this repo called vim.
\" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'Valloric/YouCompleteMe'
\" Install L9 and avoid a Naming conflict if you've already installed a
\" different version somewhere else.
\" Plugin 'ascenator/L9', {'name': 'newL9'}

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
./install.py --clang-completer --system-libclang --system-boost
