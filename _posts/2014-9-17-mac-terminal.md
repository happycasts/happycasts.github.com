https://github.com/sorin-ionescu/prezto

- zsh 到底比 bash 强在哪里
  - zsh 用起来跟 bash 基本是一样的，只是比 bash 多一些很实用的功能
   - kill vim<tab>
   - ls -<tab>
  - 先给大家装上 zsh 演示完 zsh 默认自带的功能再去演示 prezto
    - lion 以后的系统 zsh 是默认安装的

- 第一个问题，非要使用 iterm2 吗？
  Yes
  http://iterm2.com/features.html

  iterm2 中很容易在 profile 中配置，使用前面 tab 的 CWD
  iterm2 的分屏还是比 terminal 漂亮多了

- iterm2 样式设置
  真正要改变字体行间距这些样式，要使用
  iTerm2 的 theme

  iterm2 使用
  https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Misterioso.itermcolors
  preferences -> profile -> color -> preset -> import
  超级漂亮了

  - veritical line spacing
    设置的越大，看起来越清爽，尤其在有中文的时候

  - 分屏后的 dim 我不想要
    - preferences -> apperence -> dimming

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
