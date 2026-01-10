fileswitch.vim
========

fileswitch is a Vim plugin for switching quickly between files.

Default Binds
--------
#### Normal Mode
`ALT+1` switches to the first file that's still open.<br>
`ALT+2` switches to the second file.<br>
...<br>
`ALT+9` switches to the ninth file.<br>
`ALT+0` switches to the tenth file.

Installation
------------
Install with a plugin manager of your choice, or use Vim's native package manager:

    mkdir -p ~/.vim/pack/plugins/opt
    cd ~/.vim/pack/plugins/opt
    git clone <repository_url>
    
Then add the following line to your `.vimrc`:

    packadd fileswitch
