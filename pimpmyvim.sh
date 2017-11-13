# author: alz2@illinois.edu
echo "Pimping your vim... "

# get ncurses
wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz
# untar
tar -xzf ncurses-6.0.tar.gz
mkdir ~/EWSVim
cd ncurses-6.0/
./configure --prefix=$HOME/EWSVim/ncurses
make && make install

# install Vim
wget ftp://ftp.home.vim.org/pub/vim/unix/vim-8.0.tar.bz2
tar -xzf vim-8.0.tar.bz2
cd vim80
export LDFLAGS="-L$HOME/EWSVim/ncurses/lib"
# configure vim with python interpreation
./configure --enable-gui=no --without-x -with-features=huge --prefix=$HOME/Applications/vim --with-tlib=ncurses --enable-pythoninterp=yes
make && make install

