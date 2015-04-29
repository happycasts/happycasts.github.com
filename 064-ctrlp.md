---
layout: shownote
title: Ctrlp
---
__Notes:__ 本期是[第24期](http://haoduoshipin.com/episodes/24)的改进版。内容受到 [hpyhacking](https://github.com/hpyhacking) 的指导。

__Resources:__

- [ctrlp](https://github.com/kien/ctrlp.vim)

~~~
let g:ctrlp_map = ',,'
let g:ctrlp_open_multiple_files = 'v'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git)$',
  \ 'file': '\v\.(log|jpg|png|jpeg)$',
  \ }
~~~

