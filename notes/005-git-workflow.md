~~~
[user]
    name = Peter Wang
    email = happypeter1983@gmail.com
[core]
    editor = vim
[alias]
    ci = commit -a -v
    throw = reset --hard HEAD
    throwh = reset --hard HEAD^
~~~

~~~
git add .
git ci
git diff
git throw
git throwh
~~~

~~~
git ci
git checkout hello.h
~~~

~~~
git stash
#work on sth else and commit it
git stash apply
~~~

~~~
git checkout -b tmp
git checkout master
git branch -D tmp
git checkout fe544a -b tmp
~~~