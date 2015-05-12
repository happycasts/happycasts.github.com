---
layout: shownote
title: Git diff
---
### 1. 系统自带 diff

作用：查看两个比较类似的东西的差异，这两个东西可以分别是单个文件，也可以是目录（包含多个文件）

~~~
diff -u file1 file2
diff -Nurp dir1 dir2
~~~

### 2. git diff 相关

- 可以用 `git status` 查看当前 *working tree* 的修改情况

- `git add README` 可以把 *README* 添加到 *.git/index* 之中，这样可以达成两个效果：
   - *README* 从*untracked* 变为 *tracked* 文件
   - *README* 之中的内容已经成功的被 staged，成为下一次 `commit` 的原料

### 3. 基础理论 **Progit Book**

- <http://git-scm.com/book> （官网，在墙外）
- <https://github.s3.amazonaws.com/media/progit.en.pdf>
- <http://labs.kernelconcepts.de/downloads/books/Pro%20Git%20-%20Scott%20Chacon.pdf>


- **Git dir(repository)** 对应 *.git/*
- **Staging area** 也叫 **index**， 对应 *.git/index*
- **Working Tree** 对应项目目录下除了 *.git/* 之外的内容

### 4. git diff 的核心内容

- `git diff --staged` 用来查看 *staging area* 中的内容，也就是下次将要被做到下个版本之中去的内容
- `git diff` 用来查看我们在最新版本之上做的所有修改之中还没有放到 *staging area* 中的这部分
- `git diff HEAD` 以上两者之和，用来看总共的修改内容

### 5. 高级技巧

- `git diff one_commit_hash another_commit_hash`
   看新老两个版本之间的 diff
   NOTE: 这里的 `commit_hash` 就是所谓的“版本号”，其本质是 git 中 **commit** 这种 object 的40位 sha1 哈希。

- `git diff filename` 或者 `git diff dirname/`
   查看指定文件或目录的修改

- `git diff one_branch_name another_branch_name`
   对比两个分支之间的差异

