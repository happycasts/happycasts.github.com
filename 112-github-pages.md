---
layout: shownote
title: Nvd3
---

关于 Github Pages 的其他的很多事，我在 <http://happypeter.github.io/gitbeijing/pages.html> 都聊过了，所以这期视频里面就瞄准 Jekyll 的使用了。

### Jekyll 的宏观特征

>Take a look at index.html. This file represents the homepage of the site. At the top of the file is a chunk of YAML that contains metadata about the file. This data tells Jekyll what layout to give the file, what the page’s title should be, etc. In this case, I specify that the “default” template should be used. You can find the layout files in the _layouts directory. If you open default.html you can see that the homepage is constructed by wrapping index.html with this layout.


>You’ll also notice Liquid templating code in these files. Liquid is a simple, extensible templating language that makes it easy to embed data in your templates. For my homepage I wanted to have a list of all my blog posts. Jekyll hands me a Hash containing various data about my site. A reverse chronological list of all my blog posts can be found in site.posts. Each post, in turn, contains various fields such as title and date.


Jekyll 使用的一个小窍门是，直接用人家写好的 jekyll 网站，先跑起来，然后一点点的改。不过下面我一步步的添加功能进来，帮你清晰的看看 jekyll 的功能模块，很傻瓜的。
[这里](https://github.com/jekyll/jekyll/wiki/sites) 有很多网站可以参考。

首先，也是 jekyll 最大的一块就是，不写 html 了，改写 markdown，这样就先要创建 _config.yml 文件

{% highlight yaml %}
markdown: kramdown
{% endhighlight %}


第二步，也是超实用的，添加 layout 文件。


第三步，博客相关的功能。
http://happycasts.net/episodes/6  06：40
用 jeyll 也不一定非要做出博客网站。例如 happypeter.github.io/happysublime  http://happypeter.github.io/gitbeijing/


http://jekyllrb.com/docs/permalinks/ 链接格式

- 代码高亮详细说说。
  - 每个高亮 class 的意义：https://github.com/mojombo/tpw/blob/master/css/syntax.css
  - pygment: true 现在应该不用设置了，默认就是 true 见 https://help.github.com/articles/using-jekyll-with-pages/
    - 默认是 rouge 了 http://jekyllrb.com/docs/configuration/


<!-- 
- http://jekyllrb.com/docs/configuration/ 可以配置 kramdown 用 GFM 
  - 试了一下 ```ruby 这种形式还是实现不了高亮，所以还是用 liquid 格式的吧
  - 统一挺好
  - 这样只需要在 _config.yml 中什么都不做就行了，默认就是 kramdown
-->

最终一个 jekyll 项目都会有这些内容：http://jekyllrb.com/docs/structure/


### octopress
octopress 可以看看：http://happycasts.net/episodes/36



### jekyll 出错和调试

使用 jekyll 会经常写错东西。这个是事实。

### jekyll 可以安装到本地

一方面是调试用，另一方面可以这样，用 jekyll 的规范用 markdown 写成网站，然后导出成 html，这样可以放到任意一个服务器上了，即使那里没有 jekyll 支持，jekyll 本身就是 “静态网站生成器”，一个文本格式转换工具。

http://jekyllrb.com/ 这个网站本身就是采用这个形式，markdown 格式的源码在  https://github.com/jekyll/jekyll/tree/master/site  gh-pages 分支上是导出后的 html 。

http://jekyllrb.com/docs/usage/

现在有专门的论坛了：https://talk.jekyllrb.com/