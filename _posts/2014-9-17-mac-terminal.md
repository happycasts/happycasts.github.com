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

prezto 使用的是 zsh 。zsh 用起来跟 bash 基本是一样的，只是比 bash 多一些很实用的功能

和 prezto 比较类似的一个框架是 oh-my-zsh，raiilcasts 上有一个介绍视频：
<http://railscasts.com/episodes/308-oh-my-zsh?view=comments>

   - kill vim<tab>
   - ls -<tab>

- modules
  git commit -al<tab> 列出匹配项，带有说明
  - check README to know about this module

  - zsh-syntax-highlighting
    Requirements: zsh 4.3.17+.

    - update zsh
      http://zanshin.net/2013/09/03/how-to-use-homebrew-zsh-instead-of-max-os-x-default/
      - brew install zsh
      - add the brew zsh to /etc/shells

        /bin/bash
        /bin/csh
        /bin/sh
        /bin/tcsh
        /bin/zsh
        /usr/local/bin/zsh

      - chsh -s /usr/local/bin/zsh
      - check current shell version

        ~ ❯❯❯ echo $SHELL
        /usr/local/bin/zsh
        ~ ❯❯❯ /usr/local/bin/zsh --version
        zsh 5.0.6 (x86_64-apple-darwin12.5.0)

    - 最后一行，加上 syntax-highlighting 这个

      zstyle ':prezto:load' pmodule \
      'environment' \
      '...' \
      'prompt' \
      'syntax-highlighting'

    - 就加上面一行就 OK 了，其他的内容没有必要改
      zstyle ':prezto:module:syntax-highlighting' color 'yes' 这个用不着
      也没有必要去 enable 其他的 highlighter，基本的完全够用



-启动脚本出问题了
  - .profile .bashrc 等都不加载了，没事，都直接写到 .zshrc 中就好了
  - $PATH 中没有 ~/bin 也加到 .zshrc 中吧
  - 除了 .zshrc prezto 还安装了 .zprofile 和 .zpreztorc
    文件，各自的分工和启动顺序要搞清楚。
    - .zshrc 应该是 zsh 一起动就会加载，里面呼叫 .zpresto/init.sh 里面呼叫了
      .zprestorc
   - .zprofile 比 .zshrc 还早：# Executes commands at login pre-zshrc.
     - .zshenv 是最早被呼叫的，http://zsh.sourceforge.net/Intro/intro_3.html
       https://github.com/sorin-ionescu/prezto/blob/master/runcoms/README.md
       里面 source 了 .zprofile

     - 系统上还有 .zlogin 和 .zlogout

   - 推荐的方案，如果需要自定制，就都放到 .zshrc
     中，因为它加载的比较晚，可以覆盖前面  .zprofile 中得内容
     原来放在 .bashrc 中的内容也要拷贝过来
     - .zprestorc  中自然是放 zpreztorc 自己的配置，这个没什么说的
