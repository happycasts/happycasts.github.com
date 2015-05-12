__NOTE:__ 本期是[第9期](http://haoduoshipin.com/episodes/9)的改进版，但是本期也宣布作废，改进版在[第64期](http://haoduoshipin.com/episodes/64)

__Resources:__

- [fuzzfinder homepage](http://www.vim.org/scripts/script.php?script_id=1984)
- [Cmd-T](https://wincent.com/products/command-t)
- [CtrlP](http://kien.github.com/ctrlp.vim/)

~~~
unzip vim-fuzzyfinder.zip -d ~/.vim; unzip vim-l9.zip -d ~/.vim
~~~

~~~
h fuf
helptags ~/.vim/doc/
FulCoverageFile!
~~~

~~~
map ,,  :FufCoverageFile!<cr>
let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|(tmp|log|db/migrate|vendor)'
let g:fuf_enumeratingLimit = 5000
let g:fuf_coveragefile_prompt = '=>'
~~~

~~~
h fuf-search-patterns@en
~~~