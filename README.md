# EWSVim
![image](https://user-images.githubusercontent.com/21376548/32794373-47e1d16a-c92e-11e7-9a02-69beabd0cb4e.png)
Tired of vanilla EWS Vim? Why not upgrade to vim 8 and install awesome plugins such as YCM to make life easier? Oh wait, we don't have EWS sudo access. :( BUT DON'T WORRY, I GOTCHU


Installation
```
git clone https://github.com/alz2/EWSVim.git
cd EWSVim/ 
./pimpmyvim.sh
```

# What This Script Does
1) Install [ncurses](https://www.gnu.org/software/ncurses/) by from source
2) Install Vim 8.0 from source
3) Install [Vundle](https://github.com/VundleVim/Vundle.vim) for vim
4) Install [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) via Vundle

# More information
To have the newly built vim8 as your default, this script prepends the path to the vim8 binary to your $PATH by modifying your bashrc. It will not delete any lines of your bashrc. The script also modifies your .vimrc by prepending Vundle lines. With this being said, it will not delete any lines of your vimrc either. This script also will NOT destroy your EWS machine... you can look at the source code if you don't believe me. Additionally, the work this script does is easily removable, just read the next section!

# Deletion
1) Remove last line of your .bashrc. This will revert you back to vanilla EWS Vim. 
2) Remove Vundle lines from your vimrc. This will disable Vundle
3) Optional: Remove EWSVim/ and .vim/bundle


# Helpful Sources
[Vim without sudo](http://hep-comp.blogspot.com/2011/07/vim-install-no-root-privileges.html)

# Special Thanks
Thanks to [Kyle](https://github.com/patelkyle022) for letting me test my script on his EWS Machine :)
