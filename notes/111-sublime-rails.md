早在 [85期](http://haoduoshipin.com/episodes/85) 的时候，我介绍了 sublime 的基本使用，这一期里做一下扩展，说说具体在开发 Rails 程序的时候会用到的一些技巧。其实大部分内容都是不局限于 Rails 的，应该是 Web 开发领域的同学们都通用的。

我主要就讲两个技巧，一个 emmet ，另一个是 snippets 的管理。然后再来展示一些必备的，但是比较简单的其他技巧。

### emmet

主要提供的就是在 html 和 css 中的自动补全。
各种 snippet 的触发关键词，可以参考[作弊小抄](http://docs.emmet.io/cheat-sheet/)。

在 html 文件中，可以执行

```html
!<tab>
link:css<tab>
.side<tab>
.side>.nav<tab>
a<tab>
#header<tab>
ul>li*5<tab>
```

在 css 文件中，有下面的缩写形式

```css
p20<tab>
bg<tab>
m0-auto<tab>
```

基本上就是你敲一个缩写形式，然后 tab 一下，就出来了最终想要的内容。

当然还有一些灵活用法，见：<http://docs.emmet.io/actions/>。

我只举一个我觉得最常用的例子，[这里](http://docs.emmet.io/actions/wrap-with-abbreviation/) 看到 emmet 可以提供 把选中的内容用标签来包裹的功能，但是文档中 Shift-Cmd-A 在 sublime 中已经被占用了，那么这时候可以用命令面板，敲 `Wrap with...` 这样就可以看到快捷键了。 配套使用的一个功能是 `Remove Tag`，也可以用同样的方法找到快捷键。

对 emmet 的默认行为不满意还可以自定制一下：<http://docs.emmet.io/customization/> 。

### snippets

除了 emmet 自带的这些 snippet ，还可以定制自己的 snippet 。

通过 shift-cmd-p 然后敲 `snippet...` 可以看到已有的适合当前文件类型的 snippet 。emmet 中定义的 snippet 不会在这里列出，因为现在用的是 sublime 的自带 snippet 系统。

创建自己的 snippet，到 tools->new snippet 。 新建的 snippet 会自动存放到

    /Users/peter/Library/Application Support/Sublime Text 3/Packages/User

文件后缀也要自己加，叫 xxx.sublime-snippet 才可以。如果将来自己定义的 snippet 很多，sublime
也可以让用户自己设置快捷键的生效文件类型，并且可以新建目录来对众多的 snippet 进行组织。

<!-- 编辑修改 snippet，也没有找到好方法，不过直接到那个目录下去改也不算麻烦 -->

通过安装包来添加 snippet 进来，install package-> snippet... 可以看到很多被人总结好的 snippet ，不过实话说这个我就很少用了，因为记不住那么多。

### MUST HAVE

SyncedSideBar，autorein  dent，SublimeERB，AdvancedNewFile，sass 这几个包也都是非常有用的，都可以通过 package control 来进行安装。

总结一下，原则上我追求比较简单的编辑器设置，因为多了就影响编程了，脑子都用在想快捷键上了，蠢！但是非常必要的时候我也会添加一些配置进来，列位可以到  [happypeter/sublime-config](https://github.com/happypeter/sublime-config) 仓库中去查看。