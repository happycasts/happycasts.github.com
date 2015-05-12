---
layout: shownote
title: Small commits please
---
- 给大家展示一下我的 .gitconfig 文件

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

- 做小的 commit，使得回滚成为可能

~~~
git throw = git reset --hard HEAD
git throwh = git reset --hard HEAD^
~~~

- 回滚单个文件

~~~
git checkout filename
~~~

- 合并多个小版本

~~~
git rebase -i HEAD~~~
~~~

