- <https://www.sublimetext.com/>

sublime 是支持多点同时编辑的。

命令面板可以让我不必去记忆各种快捷键。

快速查找字符串和快速切换文件。

设置自己的快捷键，或者查看已经定义了那些快捷键。打开命令面板，搜 `key binding` 。
~~~

[
{ "keys": ["ctrl+shift+right"], "command": "move_to", "args": {"to": "eol", "extend": false} },
{ "keys": ["ctrl+shift+left"], "command": "move_to", "args": {"to": "bol", "extend": false} },
{ "keys": ["ctrl+shift+o"], "command": "prompt_open_folder" },
{ "keys": ["ctrl+shift+."], "command": "erb" },
{ "keys": ["ctrl+alt+n"], "command": "advanced_new_file"},
{ "keys": ["shift+tab"], "command": "reindent" , "args": { "single_line": false } }
]

~~~

查找操作对应的精确的命令名，以便设置快捷键。有时候，我用鼠标点击某个选择执行了一个操作但是我并不知道这个操作的名字，所以就没有办法来设置快捷键了。这时候敲 Ctrl+到引号 就可以打开终端，里面执行 `sublime.log_commands(True)` 这样后续操作的命令名就可以打印出来了。

### 安装功能扩展包

可以手动拷贝到 Packages 目录下，或者可以通过 Package Control 工具来进行安装。

sublimeLinter 可以来检查语法错误。

~~~
{
	"color_scheme": "Packages/RailsCasts Colour Scheme/RailsCastsColorScheme.tmTheme",
	"font_size": 11.0,
	"ignored_packages":
	[
  "Vintage",
  "SublimeLinter"
  ],
  "save_on_focus_lost": true,
  "tab_size": 2,
  "translate_tabs_to_spaces": true,
  "trim_trailing_white_space_on_save": true
}
~~~