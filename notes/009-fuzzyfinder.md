__NOTE:__ 本期视频宣布作废，改进版在[第24期](http://haoduoshipin.com/episodes/24)

__Resources:__

- [fuzzfinder homepage](http://www.vim.org/scripts/script.php?script_id=1984)
- [Cmd-T](https://wincent.com/products/command-t)

~~~
unzip vim-fuzzyfinder.zip -d ~/.vim
unzip vim-l9.zip -d ~/.vim 
~~~

~~~
h fuf 
helptags ~/.vim/doc/ 
FulCoverageFile 
FulCoverageFile! 
let g:fuf_coveragefile_globPatterns = ['**/*.erb']
~~~

~~~
map ,,  :FufCoverageFile <cr> 
let g:fuf_coveragefile_globPatterns = ['**/*.erb'] 
~~~

~~~
h g:fuf_coveragefile_globPatterns 
~~~