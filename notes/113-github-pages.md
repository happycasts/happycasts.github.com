关于 Github Pages 的基本原理，我在 <http://happypeter.github.io/gitbeijing/pages.html> 都聊过了，所以这期视频里面就瞄准 Jekyll 的使用了。

Jekyll 使用的一个小窍门是，直接用人家写好的 jekyll 网站，先跑起来，然后一点点的改。
[这里](https://github.com/jekyll/jekyll/wiki/sites) 有很多网站可以参考。 一个 jekyll 项目都会有这些内容：<http://jekyllrb.com/docs/structure/> 。不过下面我一步步的添加功能进来，帮你清晰的看看 jekyll 的功能模块，很傻瓜的。

到一个项目仓库，添加 gh-pages 分支，然后里面放一个 index.html 咱们的 jekyll 网站就算跑起来了。

### markdown 解析器的选择

首先，也是 jekyll 最大的一块就是，不写 html 了，改写 markdown，可以把原有的 index.html 页面改写为 index.md 。[默认配置](http://jekyllrb.com/docs/configuration/) 的后缀有下面列出的几种

    markdown_ext: "markdown,mkdown,mkdn,mkd,md"

所以其他几种后缀也都是没有问题的。但是要注意的是在 index.md 中，开始正文之前，一定要加上下面这样的”头设置“ ( Front Matter )

```yaml
---
title: 测试页面
---
```

知道 jekyll 的各个配置的默认值是非常重要的，直接影响日常使用。好在官网的 [配置页面](http://jekyllrb.com/docs/configuration/) 上这部分内容列出的都很清楚。比如默认的 markdown 转换器是

    markdown:    kramdown

知道了这个，就可以到 [kramdown 官网](http://kramdown.gettalong.org/) 查看关于 kramdown 官网的使用细节，不过初期也用不着，看看我这里怎么写，照猫画虎就成。

### 布局文件和片段文件
来添加 _layouts/default.html 文件，内容为

{% gist happypeter/4be09d49c828d3fe788c %}

然后到 index.md 页面 front matter 部分，添加

```yaml
layout: default
```

其他想应用相同布局文件（ layout ）的 markdown 文件中也都添加相同内容就可以。跟布局文件相对的就是片段文件了，参考 [这个项目页面](https://github.com/happypeter/gitbeijing/blob/gh-pages/index.md) 中的

    include toc.html

一看就明白是什么意思了。

### 配置文件设置
每个页面中都重复添加 `layout: xxx` 也挺傻的。在 _config.yml 中添加，

```yaml
defaults:
  -
    values:
      layout: "default"
```

这样相当于为每个页面都默认设置了布局文件。

这样，每个页面中的 layout 这一项就不用设置了。但是要注意，即使有了这个设置，front matter 部分也不能完全删除。没有内容要设置，也要给一个空的 front matter

```yaml
---
---
```

另外，个别页面如果不用这个 layout 文件，可以到 front matter 中去覆盖，例如

```yaml
---
layout: post
---
```

这样这个页面就使用 post.html 做布局文件了。

### 代码高亮

我自己经常写一些关于代码的文章，所以对代码高亮非常关心，下面详细来说说 jekyll 下如何实现代码高亮。

[官网配置页面](http://jekyllrb.com/docs/configuration/) 上可以看到，默认的 highlighter 现在是 rouge 。
 
 如何设置合适的语法扫描器 lexer 是很重要的。
 在 [pygment 官网](http://pygments.org/docs/lexers/) 可以找到全部的 lexer 。rouge 是 pygments 的一个克隆， 但是并不能支持所有 pygments 的 lexer ，具体见[这里](https://github.com/jneen/rouge/wiki/List-of-supported-languages-and-lexers) 。

 所以如果你的语言正好没支持，可以到 _config.yml 中，添加

```yaml
highlighter: pygments
```

来覆盖默认设置。相关官网内容，[check here](http://jekyllrb.com/docs/templates/) 。

<!-- - http://jekyllrb.com/docs/posts/ 有代码高亮的讨论，看来想高亮必须用 liquid 没有其他选择 -->

高亮有了，就是每个代码的关键字都加上了合适的 html class 名了，具体 pygment 语法下面每个高亮 class 的意义，可以参考 [here](https://github.com/mojombo/tpw/blob/master/css/syntax.css) 。下面就来添加自己喜欢的 css 样式了。最简单的还是用人家现成写好的，例如我的这些项目。

比较大段的代码也可以考虑用 gist 嵌入的形式，参考 [here](http://jekyllrb.com/docs/templates/)，具体效果本页面上就可以看到。

### 其他

sass 和 coffee 的预处理，参考 [这里](http://jekyllrb.com/docs/assets/) 。 sass 使用的一个实例，[gitbeijing](https://github.com/happypeter/gitbeijing/blob/gh-pages/css/main.scss) 。

[自带变量](http://jekyllrb.com/docs/variables/) 也是很有用的。例如 gitbeijing 中为了给每个章节加大标题，在 book.html 中有 

{% gist happypeter/cc3f896eee9089622512 %}

同时 head.html 中有

{% gist happypeter/d04d1032a41d811f7eb7 %}

这样一来，只需要在头设置中有

```yaml
title: xxx
```

就同时设置好了这两个地方了，真是方便。你肯定注意到了上面的这些变量进行运算时都会被包裹在双括号里面，这个是 liquid 语法。更多 liquid 的技巧参考 [这里](http://jekyllrb.com/docs/templates/) 。

jekyll 是一个静态网站生成器，但是同时是一个专门针对博客功能强化过的静态网站生成器。支持博客格式的功能，也用到了一些自带变量。 例如 `site.posts`，具体例子，可以看看 Peter 的博客的[首页源码](https://github.com/happypeter/happypeter.github.com/blob/master/index.markdown) 。当然要使用这样变量来巧妙的取出每一篇博客的具体信息，就要求每一篇博客的命名和存放路径都有符合一定的规范，参考 [here](http://jekyllrb.com/docs/posts/) 。[设置每篇博客的永久链接格式](http://jekyllrb.com/docs/permalinks/) 以及 [分页功能](http://jekyllrb.com/docs/pagination/) 官网上也都有详细介绍。

另外，jekyll 已提供了一个可爱型的数据库。参考[这里](http://jekyllrb.com/docs/datafiles/) 。

### jekyll 可以安装到本地

自己本地安装和配置 jekyll 的方法，参考 <http://jekyllrb.com/docs/usage/> 。为什么要费力气自己安装呢？

一方面是方便调试，使用 jekyll 会经常写错东西，造成转换失败。好消息是其实常见的错误只有很小的几个类型。参考[这里](http://jekyllrb.com/docs/troubleshooting/) 。 如果只是为了调试，我一般是不在本地安装 jekyll 的，一旦我新 push 的内容一分钟后没有在页面上体现出来，我就会打开邮箱，github 会给发报错邮件的，根据上面的信息修改一下就好了。

另一方面可以这样，用 jekyll 的规范用 markdown 写成网站，然后导出成 html，这样可以放到任意一个服务器上了，即使那里没有 jekyll 支持，jekyll 本身就是 “静态网站生成器”，一个文本格式转换工具。 <http://jekyllrb.com/> 这个网站本身就是采用这个形式，markdown 格式的源码在 <https://github.com/jekyll/jekyll/tree/master/site> ， gh-pages 分支上是导出后的 html 。

### 总结

如果你想要给网站添加 rss 用 google analytics 监控浏览，添加 disqus 评论等很多其他常用功能，那么可以考虑使用 [octopress](http://octopress.org/docs/) 。octopress 是专门为 Jekyll 而设计的一个博客框架，提供了不少实用的功能，不过如果你不熟悉 ruby 可能配置实用起来会比较费时间。