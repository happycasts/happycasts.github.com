---
layout: shownote
title: Sublime warmup
---
- <https://www.sublimetext.com/>

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

