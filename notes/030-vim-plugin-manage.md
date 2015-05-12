__Resources:__

- [Vundle](https://github.com/gmarik/vundle)
- [pathogen](https://github.com/tpope/vim-pathogen)
- <http://vim-scripts.org/>
- [vimcast git submodule](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/)

~~~
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -so ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
~~~

~~~
git clone git@github.com:happycasts/dotvim.git
mv dotvim .vim
ln -s .vim/vimrc .vimrc
~~~

~~~
call pathogen#infect()
syntax on
filetype plugin indent on
~~~

~~~
:set runtimepath
:Helptags
~~~