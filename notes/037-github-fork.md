---
layout: shownote
title: Github fork
---
- <https://help.github.com/articles/fork-a-repo> 
- <https://help.github.com/articles/using-pull-requests> 

### 1. 要注意的地方

不要直接在 master 上写代码
因为我们本地的 master 主要是用来跟踪上游 master 的 

### 2. 很有用的 branch 操作

本地新建分支
~~~
git check -b add_sth
~~~
 
把本地的 add_sth 分支保存的 github 上 
~~~
git push orign add_sth
~~~
 
删除本地 add_sth 分支
~~~
git branch -D add_sth
~~~
 
删除 github 上的 add_sth 分支 
~~~
git push orign :add_sth
~~~

