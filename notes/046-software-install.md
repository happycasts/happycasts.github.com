### 1. Makefile 的一个小教程
- <http://www.opussoftware.com/tutorial/TutMakefile.htm> 

### 2. 一个 C 语言的接口的使用

比如我们的代码里调用的一个 C 的库函数，那我们知道它来自一个叫做 `xxx` 的 C 库，我们有两步要做

    sudo apt-get install libxxx-dev
    
去安装编译这个程序的时候所需要的头文件。还需要

    sudo apt-get install libxxx
    
去安装实际的包含此接口具体实现的 binary 的库。

Why? 参考：

- <http://www.tldp.org/HOWTO/pdf/Program-Library-HOWTO.pdf> 

### 3. apt-get 和 homebrew 还有 rubygems 很不一样

- apt-get 直接从仓库里下载编译好的二进制来安装。
- homebrew 和 rubygems 
一般下载源码，在本地编译，这就要求本地的编译环境要完好。