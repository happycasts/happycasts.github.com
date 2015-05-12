~~~
vim --version|head -n 1
lsb_release -a
~~~

~~~
:h i_CTRL-X_CTRL-K
:h i_CTRL-X_CTRL-L
:h i_CTRL-X_CTRL-F
:h i_CTRL-X_s
:h i_CTRL-N
:h new-omni-completion
~~~

~~~
snippet tag
    ${1:name} {
      ${2:attr:} ${3:value};
    }
~~~

~~~

"""""""""""""""""""""""""""""""""""""""""""""""""
"
"       ignore case for i_Ctrl-N
"
"""""""""""""""""""""""""""""""""""""""""""""""""
set ic

"""""""""""""""""""""""""""""""""""""""""""""""""
"
"       set dictionary to use i_Ctrl-X_Ctrl-K
"
"""""""""""""""""""""""""""""""""""""""""""""""""
set dictionary+=/usr/share/dict/words

"""""""""""""""""""""""""""""""""""""""""""""""""
"
"       i_Ctrl-X_s won't work without spell-checking enabled
"
"""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map ,ss :setlocal spell!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""
"
"       :h new-omini-complete
"
"""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on

"""""""""""""""""""""""""""""""""""""""""""""""""
"
"       Just for fun
"
"""""""""""""""""""""""""""""""""""""""""""""""""
ia xdate  <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
ia myname <c-r>%<cr>
~~~