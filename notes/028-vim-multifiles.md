__Resources:__

- [One Vim...Just One](http://vimeo.com/4446112) 
- [Derek Blog](http://derekwyatt.org/) 
 
~~~
:h buffers
:ls
:bd
:b 3 
:h new-vim-server 
~~~

~~~
vim --servername VIM-SERVER route.rb
vim --servername VIM-SERVER --remote-silent route.rb 
~~~
  
~~~
set laststatus=2
set statusline=%F:\ %l
set hidden "in order to switch between buffers with unsaved change
map <s-tab> :bp<cr>
map <tab> :bn<cr>
~~~