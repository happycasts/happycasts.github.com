---
layout: shownote
title: Sublime Text 辅助 Rails 开发
---


早在 [85期](http://happycasts.net/episodes/85) 的时候，我介绍了 sublime 的基本使用，这一期里做一下扩展，说说具体在开发 Rails 程序的时候会用到的一些技巧。其实大部分内容都是不局限于 Rails 的，应该是 Web 开发领域的同学们都通用的。

我主要就讲两个技巧，一个 emmet ，另一个是 snippets 的管理。然后再来展示一些必备的，但是比较简单的其他技巧。

### emmet

主要提供的就是在 html 和 css 中的自动补全。
各种 snippet 的触发关键词，可以参考[作弊小抄](http://docs.emmet.io/cheat-sheet/)。


{% highlight css %}
p20<tab>
bg<tab>
m0-auto<tab>
{% endhighlight %}


{% highlight html %}
!<tab>
link:css<tab>
.side<tab>
#header<tab>
{% endhighlight %}

基本上就是你敲一个缩写形式，然后 tab 一下，就出来了最终想要的内容。

当然还有一些挺实用的灵活用法，参考：http://docs.emmet.io/actions/。

http://docs.emmet.io/actions/wrap-with-abbreviation/ 这里可以看到 emmet 可以提供
把选中的内容用标签来包裹的功能，但是文档中 Shift-Cmd-A 在 sublime 中已经被占用了，那么这时候可以用命令面板，敲 `Wrap with...` 这样就可以看到快捷键了。

配套使用的一个功能是 `Remove Tag`。

对 emmet 的默认行为不满意还可以自定制一下：http://docs.emmet.io/customization/


### snippets

除了 emmet 自带的这些 snippet ，还可以定制自己的 snippet 。

通过 shift-cmd-p 然后敲 `snippet...` 可以看到已有的适合当前文件类型的 snippet 。emmet 中定义的 snippet 不会在这里列出，因为现在用的是 sublime 的自带 snippet 系统。


创建自己的 snippet，到 tools->new snippet 。
新建的 snippet 会自动存放到

    /Users/peter/Library/Application Support/Sublime Text 3/Packages/User

文件后缀也要自己加，叫 xxx.sublime-snippet 才可以。如果将来自己定义的 snippet 很多，sublime
也可以让用户自己设置快捷键的生效文件类型，并且可以新建目录来对众多的 snippet 进行组织。但是，如果
snippet 的数量不多，那就没有必要麻烦了。

<!-- 编辑修改 snippet，也没有找到好方法，不过直接到那个目录下去改也不算麻烦 -->

通过安装包来添加 snippet 进来，install package-> snippet... 可以看到很多被人总结好的 snippet ，不过实话说这个我就很少用了，因为记不住那么多。

### MUST HAVE

SyncedSideBar，autoreindent，SublimeERB，AdvancedNewFile，sass 这几个包也都是非常有用的，都可以通过 package control 来进行安装。
