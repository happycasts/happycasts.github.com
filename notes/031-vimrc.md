### 1. `.vimrc` 基本介绍

~~~
:so peter.txt
:h vimrc
:scriptnames
~~~

~~~
function! Browser()
  let line = getline(".")
  exec "!firefox ".line
endfunction
~~~
### 2. 快捷键映射（ mappings ）

~~~
map ,w :call Browser()<cr>
imap jj <esc>
~~~

~~~
:h map.txt
~~~

### 3. 选项设置（ settings ）

~~~
set nu
set tabstop=2
set tabstop=4
~~~

~~~
:h option-list
:set nonu
:set nu?
:set tabstop?
:options
~~~

### 4. 自运行命令（ autocmd )

~~~
autocmd FileType c set tabstop=4
autocmd FileType html set tabstop=2
autocmd BufWritePost ~/my_proj/* !ctags -f ~/my_proj/tags ~/my_proj/*
~~~

~~~
:h autocmd.txt
~~~

### 5. 更多信息

~~~
:h usr_05.txt
~~~