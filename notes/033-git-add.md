### 1. 基本概念

作用：将 working tree 中的修改添加到 index 之中。

### 2. 什么是 tracked ?

一个人文件被跟踪（tracked）就是它的已经在 index 之中挂名。可以用 `git ls-files` 来查看。

### 3. git add .

我日常用的最多的 git 命令。

### 4. 非常 cool 的东东

绝对要会的： `git add -p`
绝对要知道的: `git add -i`

### 5. 让 index 往外吐

让一个文件从下个版本中消失 = 让它在 index 中除名 = `ls-files` 不再显示它

~~~
git rm --cached file
~~~
把文件的修改从 index 中删除 = `git diff --cached` 的输出中不会有这部分修改
= commit 之后下个版本中依旧有这个文件，只是没有修改

~~~
git reset file
~~~