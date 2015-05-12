---
layout: shownote
title: Git rebase
---
__Resources:__

- <http://www.worldhello.net/gotgithub/04-work-with-others/020-shared-repo.html#id5>

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
git checkout -b dev
git pull --rebase
git rebase -i master
~~~

