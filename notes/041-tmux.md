备注：本期视频的基本内容由 [@Ming](http://blog.yunnuy.com/) 提供。

- <http://en.wikipedia.org/wiki/Tmux>

### 配置文件
~~~
unbind C-b
set -g prefix C-a
setw -g mode-keys vi

# split window like vim
# vim's defination of a horizontal/vertical split is revised from tumx's
bind s split-window -h
bind v split-window -v
# move arount panes wiht hjkl, as one would in vim after C-w
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# resize panes like vim
# feel free to change the "1" to however many lines you want to resize by,
# only one at a time can be slow
bind < resize-pane -L 10
bind > resize-pane -R 10
bind - resize-pane -D 10
bind + resize-pane -U 10

# bind : to command-prompt like vim
# this is the default in tmux already
bind : command-prompt
~~~