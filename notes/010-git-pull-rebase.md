---
layout: shownote
title: Git pull rebase
---
__Resources:__

- [github](http://www.github.com)


~~~
[user]
    name = Peter Wang
    email = happypeter1983@gmail.com
[core]
    editor = vim
[alias]
    ci = commit -a -v
    co = checkout
    st = status
    br = branch
    throw = reset --hard HEAD
    throwh = reset --hard HEAD^
[color]
    ui = true
[push]
    default = current

~~~

~~~
vim .git/config
vim .git/refs/remote/origin/master
git fetch origin
git rebase origin/master

~~~

