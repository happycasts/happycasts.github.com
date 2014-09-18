---
layout: post
title: 美丽如苹果的命令行
---

苹果的 Mac 系统自带的命令行终端，叫
terminal，用了一段时间感觉不太好。所以改成了用 iTerm2 。今天的视频我来把 iTerm2
配置一下，让命令行变得更好看。然后再安装
[prezto](https://github.com/sorin-ionescu/prezto)
这个可以让命令行变得更方便好用。最终可以达成的效果是这样的，不错吧？

![](http://media.happycasts.net/pic/happycasts/endresult.png)


# 更好用的终端软件 iTerm2

使用 Ctrl-D 来分屏操作。在这里 <http://iterm2.com/features.html> 可以看到 iterm2
提供的各种功能，我觉得我最喜欢的就是这个分屏了。这边我正用 vim
修改配置文件，突然想到命令行里面看看相应的效果，这时候如果新启动一个命令行标签，那
vim 中我编辑的内容就看不到了，极为不爽。如果我敲 Cmd-D
分出一半屏幕给命令行，哈哈，一边敲一边参照，方便啊。完事了，Ctrl-D
直接关了命令行这半边，vim 里面接着写。

新标签的工作目录。除了这些功能，iterm2 的可自定制性也比 terminal
丰富。比如默认情况下，你启动一个新的标签页，当前工作目录就是你的用户主目录。但是大部分时候，我发现保留前面的标签的工作路径比较干活方便。这样我就可以敲
Cmd+' 呼叫出 iterm2 的 preferences 页，profile，选择当前你使用的
profile，然后勾选 Reuse previous session's directory 。

安装颜色主题。
  https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Misterioso.itermcolors
  preferences -> profile -> color -> preset -> import
  超级漂亮了

设置行间距。 设置的越大，看起来越清爽，尤其在有中文的时候 

# 命令行配置框架 prezto

安装过程参考这里的 README：<https://github.com/sorin-ionescu/prezto> 。

prezto 使用的是 zsh 。zsh 用起来跟 bash 基本是一样的，只是比 bash 多一些很实用的功能

和 prezto 比较类似的一个框架是 oh-my-zsh，raiilcasts 上有一个介绍视频：
<http://railscasts.com/episodes/308-oh-my-zsh?view=comments>


配置文件。使用了 zsh 之后，原来 bash 的 .profile .bashrc
等都不加载了，没事，都直接写到 .zshrc 中就好了。 .zprestorc  中自然是放
zpreztorc 自己的配置，这个没什么说的。其他的 .zshenv .zlogin .zporfile
等等不用管。

有了 prezto
就可以通过启用它的各个模块来实现一些很帅的功能。这里我来安装一下代码高亮模块。

Mac 系统上自带的 zsh 比较老了，代码高亮模块需要我去升级 zsh 。

首先安装一个新版本的 zsh

    $ brew install zsh

可执行程序被安装在 /usr/local/bin/zsh 。

现在需要把这个路径添加到 /etc/shells 文件中

    /bin/bash
    /bin/csh
    /bin/sh
    /bin/tcsh
    /bin/zsh
    /usr/local/bin/zsh

然后设置新 zsh 为默认就可以了

    $ chsh -s /usr/local/bin/zsh

弄好后

    $ echo $SHELL
    /usr/local/bin/zsh

可见新 zsh 已经启用了。

启用高亮模块。打开 .zprestorc 文件。最后一行，加上 syntax-highlighting

      zstyle ':prezto:load' pmodule \
      'environment' \
      '...' \
      'prompt' \
      'syntax-highlighting'

这样启动一个新的 shell 试一下

    $ echo "hello"

可以看到高亮效果。同时如果输入一个不存在的命令，字体显示为红色。如果是系统可以识别的命令，则为绿色。

