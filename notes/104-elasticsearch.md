<!-- this deprecate ep#72 -->

在 [这里](http://www.elasticsearch.org/case-study/) 可以看到，github，stacketoverflow 和 basecamp 都在用 Elasticsearch （后面简称 es ） 。在 happycasts 的 [第72期](http://haoduoshipin.com/episodes/72) 中我介绍过 happycasts 当时的采用的搜索方案是 sunspot 和 solr 。但是对比一下 solr 和 es 的官网，感觉 [solr](http://lucene.apache.org/solr/) 是不关心 programmer happyness 的，文档页面感觉很粗糙。而 [es](http://www.elasticsearch.org/) 的文档系统就非常贴心，还有很多精彩的视频。这两天，我已经把 happycasts 切换到了 es 。

这一期的 happycasts 演示在 ubuntu 1204 服务器上安装 es ，以及如何在 Rails 项目中使用 es 。

# 在 ubuntu 1204 上安装 elasticsearch

在安装 elasticsearch 之前，需要安装 Java 。

登陆到我在 linode 上新开的一个 ubuntu1204 服务器上

~~~
sudo apt-get update
sudo apt-get install openjdk-7-jre-headless
java -version
~~~

es 对 Java 版本的要求 [参考这里](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup.html) 。

es 的 [下载页面](http://www.elasticsearch.org/overview/elkdownloads/) 上有添加 apt 仓库的办法。 咱们就使用这个方法安装。从安装时的信息可以看出 es 的版本是1.3.3。apt-get 完成之后，启动 es 服务：

~~~
sudo service elasticsearch start
~~~

设置开机就直接启动 es 服务：

~~~
sudo update-rc.d elasticsearch defaults 95 10
~~~

这样到我本地机器的 /etc/hosts 文件中，添加我的 linode ip 进来

~~~
xxx.xxx.xxx.xxx linode-esdemo
~~~

到浏览器，http://linode-esdemo:9200/ 看一下，如果得到如下信息，表示 es 已经可以工作了。

~~~
{
  "status" : 200,
  "name" : "Nico Minoru",
  "version" : {
    "number" : "1.3.3",
    "build_hash" : "dee175dbe2f254f3f26992f5d7591939aaefd12f",
    "build_timestamp" : "2014-08-13T14:29:30Z",
    "build_snapshot" : false,
    "lucene_version" : "4.9"
  },
  "tagline" : "You Know, for Search"
~~~

# Elasticsearch 的 REST API

几个基本概念 index ， type ，document 都要知道。可以参考 [这里](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/_basic_concepts.html) 。

不依靠 rails 的 gem，我也可以用 es 提供强大的 REST API，来实现 CRUD 操作。可以在 chrome 里面安装 sense 插件，设置 es 的位置是 linode-esdemo:9200 ，然后来跟 es 交互。注意，以下命令都一样可以使用 curl 在命令行里执行。

创建 index 名为 `users` ，创建 id 为 `1` 的用户，type 为 `user`

~~~
POST /users/user/1
{
    "name": "peter",
    "intro": "video maker"
}
~~~

再来加入第二个用户的 document

~~~
POST /users/user/2
{
    "name": "billie",
    "intro": "composer"
}
~~~

查看第一个用户的信息：

~~~
GET /users/user/1
~~~

查看一个 index 中，所以的内容：

~~~
GET _search
~~~

也可以用 API 来进行查询：

~~~
POST _search
{
   "query": {
      "query_string": {
         "query": "peter"
      }
   }
}
~~~

列出所有 index ：

~~~
GET _cat/indices?v
~~~

删除 index :

~~~
DELETE /users
~~~

[这里](http://joelabrahamsson.com/elasticsearch-101/) 有更多的操作方法，可以看看。

# Rails 中使用 Elasticsearch

现在这里有一个正在运行的简单的 rails 程序，可以创建包含用户 name 和 intro 两项内容的用户条目。现在我要给这个应用加上 es 实现搜索功能。
首先在 Gemfile 文件中添加需要的 gem 。

[代码](https://github.com/happycasts/episode-104-demo/commit/df1dcc8973012e195532f0829add822b52b5116c)

然后运行 `bundle install` ，重启一下服务器。

下一步，首页中添加一个搜索框，给 search 添加一个需要的路由，再把 css 样式弄好看一些。

[代码](https://github.com/happycasts/episode-104-demo/commit/99043a1bbb159f575ae0a2f794768972fc89b390)

接下来实现主体代码。在 user.rb 中添加对 es 功能的导入，在 users_controller 中添加 search 方法。

其中用到的 `multi_match` 可以选择搜索的字段，实例中搜索用户的名字和简介。[参考文档](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-multi-match-query.html) 。

还需要添加一个  app/views/users/search.html.erb 文件，来展示最终的搜索结果。

[代码](https://github.com/happycasts/episode-104-demo/commit/c2814a6b0f2bf743f72cbc8b44285463870f87d6)

现在搜索一下，发现新添加的数据已经可以找到了。但是如果有老数据，需要手动 index 一下。到 lib/tasks 目录下
新建一个名为 elasticsearch.rake 的文件。

[代码](https://github.com/happycasts/episode-104-demo/commit/8ca7e04e708a84dd397f813bb475a4030f9c0b0f)

保存文件，然后在命令行中执行：

~~~
bundle exec rake environment elasticsearch:import:model CLASS='User' FORCE=y
~~~

这样 users 这张表中的数据就导入到 elasticsearch 的 users 索引中了。

最后，实现一下搜索关键词高亮。参考 [这里](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-request-highlighting.html) 。

[代码](https://github.com/happycasts/episode-104-demo/commit/ca07bd77c4f88c20a38f901f70854b12a8dbaa16)

# 结语

这样 es 配合 rails 就可以提供出基本的搜索工能了。实际使用中可能还需要添加更多的功能，例如添加 [中文分词支持](https://github.com/billie66/esdemo/wiki/ik) ，后面我可能会出专门的视频介绍。谢谢！