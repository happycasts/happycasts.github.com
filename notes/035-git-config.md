---
layout: shownote
title: Git config
---
###1.  配置文件的位置

`~/.gitconfig` 是最常用的。对应的配置命令要加 `--global` 选项。

###2.  覆盖作者名

~~~terminal
git commit --author="Ben <ben@ben.com>" -a -m"ben's msg"
~~~

###3. 我的 .gitconfig

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
[merge]
    tool = meld
~~~

