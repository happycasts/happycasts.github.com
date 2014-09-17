- 命令行的高亮
  - laracasts 中是有高亮的

# 第一个问题，非要使用 iterm2 吗？
Yes
http://iterm2.com/features.html

http://railscasts.com/episodes/308-oh-my-zsh

也用 Mac 自带的 terminal，可以在新的 tab 中保留当前目录。
iterm2 中很容易在 profile 中配置

iterm2 的分屏还是比 terminal 漂亮多了

terminal 在 tab 之间切换的快捷键是 cmd+{} 而且不可更改
iterm2 要改快捷键很方便

# themes
oh-my-zsh 的 theme 是用来控制 prompt 的，

https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

真正要改变字体行间距这些样式，要使用
terminal 的 theme

iterm2 使用
https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Misterioso.itermcolors
preferences -> profile -> color -> preset -> import
超级漂亮了

- veritical line spacing
  设置的越大，看起来越清爽，尤其在有中文的时候

- 分屏后的 dim 我不想要
  - preferences -> apperence -> dimming


- plugin
  https://github.com/sorin-ionescu/prezto
  git commit -al<tab> 列出匹配项，带有说明

-启动脚本出问题了
  - .profile .bashrc 等都不加载了，没事，都直接写到 .zshrc 中就好了
  - $PATH 中没有 ~/bin 也加到 .zshrc 中吧
