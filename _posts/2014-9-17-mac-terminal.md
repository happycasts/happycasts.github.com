---
layout: post
title: 美丽如苹果的命令行
---

![](http://media.happycasts.net/pic/happycasts/apple.jpg)

苹果的 Mac 系统自带的命令行终端，叫
terminal，用了一段时间感觉不太好。所以改成了用 iTerm2 。今天的视频我来把 iTerm2
配置一下，让命令行变得更好看。然后再安装
[prezto](https://github.com/sorin-ionescu/prezto)
让命令行变得更好用。最终可以达成的效果是这样的，不错吧？

![](http://media.happycasts.net/pic/happycasts/endresult.png)

# 终端软件 iTerm2

使用 Cmd-D 来分屏操作。在这里 <http://iterm2.com/features.html> 可以看到 iterm2
提供的各种功能，我觉得我最喜欢的就是这个分屏了。

新标签的工作目录。除了这些功能，iterm2 的可自定制性也比 terminal
丰富。比如默认情况下，你启动一个新的标签页，当前工作目录就是你的用户主目录。但是大部分时候，我发现保留前面的标签的工作路径比较干活方便。这样我就可以敲
Cmd+' 呼叫出 iterm2 的 preferences 页，profile，选择当前你使用的
profile，然后勾选 Reuse previous session's directory 。

![](http://media.happycasts.net/pic/happycasts/preference.png)

安装颜色主题。来 <http://iterm2colorschemes.com/>
选择一款自己喜欢的颜色主题吧，我自己用的是
[Misterioso](https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Misterioso.itermcolors)
。到 preferences -> profile -> color -> preset 然后 import 进来就好了。

设置行间距。 到我的默认 profile 下，text -> change font，更改 charater spacing -> vitical 的值为 1.5 。我的感觉是行间距设置的越大，看起来越清爽，尤其在有中文的时候 

# 命令行配置框架 prezto

安装过程参考这里的 README：<https://github.com/sorin-ionescu/prezto> 。 prezto 使用的是zsh 。zsh 用起来跟 bash 基本是一样的，只是比 bash
多一些很实用的功能。 和 prezto 比较类似的一个框架是 oh-my-zsh，raiilcasts 上有一个介绍视频：
<http://railscasts.com/episodes/308-oh-my-zsh> 。

![](http://media.happycasts.net/pic/happycasts/prezto.png)

配置文件。使用了 zsh 之后，原来 bash 的 .profile .bashrc
等都不加载了，没事，都直接写到 .zshrc 中就好了。 .zprestorc  中自然是放
zpreztorc 自己的配置，这个没什么说的。其他的 .zshenv .zlogin .zporfile
等等不用管。

更改主题。prezto 的主题主要就是改变命令提示符的格式。可以用 `prompt -l`
命令来查看都有哪些可以用的 theme 。.zpreztorc 中相应的设置在这一行上：

    zstyle ':prezto:module:prompt' theme 'sorin'

可以修改为你自己喜欢的一个主题。

有了 prezto 就可以通过启用它的各个模块来实现一些很帅的功能。这里我来安装一下代码高亮模块。

Mac 系统上自带的 zsh 比较老了，代码高亮模块需要我去升级 zsh
。参考：<http://zanshin.net/2013/09/03/how-to-use-homebrew-zsh-instead-of-max-os-x-default/>
。

然后就可以启用高亮模块。打开 .zprestorc 文件。最后一行，加上 syntax-highlighting

      zstyle ':prezto:load' pmodule \
      'environment' \
      '...' \
      'prompt' \
      'syntax-highlighting'

这样启动一个新的 shell 试一下

    $ echo "hello"

可以看到高亮效果。同时如果输入一个不存在的命令，字体显示为红色。如果是系统可以识别的命令，则为绿色。

