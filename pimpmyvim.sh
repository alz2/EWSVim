# author: alz2@illinois.edu
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
./configure --enable-gui=no --without-x -with-features=huge --prefix=$HOME/Applications/vim --with-tlib=ncurses --enable-pythoninterp=yes
make && make install

# prepend vim 8 to $PATH so vim8 is default
echo "SETTING VIM 8 AS DEFAULT"
echo "PATH=$HOME/EWSVim/vim/bin:$PATH" >> ~/.bashrc
