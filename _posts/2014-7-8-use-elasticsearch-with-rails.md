---
layout: post
title: Elasticsearch with rails
---
[github](http://www.elasticsearch.org/case-study/github/) ，stacketoverflow 和 basecamp 都在用 Elasticsearch(es) 。在 <http://happycasts.net/episodes/72> 中我介绍过 happycasts 当时的采用的搜索方案是 sunspot 和 solr 。但是对比一下 solr 和 es 的官网，一眼看出 [solr](http://lucene.apache.org/solr/) 是非常不关心 programmer happyness 的，而 [es](http://www.elasticsearch.org/) 的文档系统就非常贴心，还有很多精彩的视频。

这两天，我已经把 happycasts 切换到了 es 。今天的视频的 demo 是 [Billie 做的这个](https://github.com/billie66/esdemo) 。

<!-- 对比一下 solr 和 es

  solr 和 es 看起来是没法比了，理由如下

 - 功能点上，比较类似 solr 也比较多，但是还是认为 es 要稍微强一点
 - star 数量不在一共等级上
   - https://github.com/apache/solr 最近更新是8年前！一共300多 star
   - https://github.com/apache/lucene-solr 也不过有几百个 star
   - https://github.com/sunspot/sunspot 2097 star
   - https://github.com/elasticsearch/elasticsearch 8400 star
 - 文档
   - http://www.elasticsearch.org/case-studies/ 很可爱，有视频，文档也丰富
   - http://lucene.apache.org/solr/solrnews.html 让我想起了甲骨文，大量文字堆叠，一点没有 programmer happyness 的概念。

 - github stackoverflow basecamp 都用 es

 - elk stack
   - http://www.elasticsearch.org/overview/kibana

总之，es 完胜，solr 已经不值得推荐了
-->

### 在 ubuntu 1204 上安装 elasticsearch 1.2.1

在安装 elasticsearch 之前，需要安装 Java, 高版本的 elasticsearch 至少需要 Java 7 才能运行。
需要注意一下，官方文档上推荐使用的是 Oracle JDK，而 Ubuntu 因版权问题默认支持的是 OpenJDK
但你自己可以手动安装 Oracle JDK，在命令行中执行以下操作:

~~~
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
java -version
~~~

最后一步操作 `java -version` 可以查看所安装的 JDK 的版本是否正确。

java version "1.7.0_67" 对吗？

以上信息来源请参考 [elasticsearch setup](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup.html)。页面上说 openjdk 也可以，但是网上很多人说这个会引起一些不明显的 bug 。

接下来要做的工作就是下载 elasticsearch，下载地址是 <http://www.elasticsearch.org/overview/elkdownloads/>，这里提供了
几种不同类型的安装包，从中选择 debian 安装包 <https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb>。

下载完毕之后，就需要安装了，运行命令：

~~~
sudo dpkg -i elasticsearch-1.2.1.deb
~~~

启动，停止，重新启动 elasticsearch 服务：

~~~
sudo service elasticsearch start|stop|restart
~~~

你也可以设置开机就直接启动 elasticsearch 服务：

~~~
sudo update-rc.d elasticsearch defaults 95 10
~~~

检测一下 elasticsearch 服务是否在运行：

~~~
$ sudo service elasticsearch status
* elasticsearch is running
~~~

或者是打开浏览器，访问本地 9200 端口 `http://localhost:9200`，若看到如下内容，则说明 elasticsearch 已经成功运行起来了。

~~~
  {
  "status" : 200,
  "name" : "Worm",
  "version" : {
    "number" : "1.2.1",
    "build_hash" : "6c95b759f9e7ef0f8e17f77d850da43ce8a4b364",
    "build_timestamp" : "2014-06-03T15:02:52Z",
    "build_snapshot" : false,
    "lucene_version" : "4.8"
  },
  "tagline" : "You Know, for Search"
}
~~~

### Elasticsearch 基本使用

Elasticsearch 安装成功之后，就要使用它了。在使用 elasticsearch 之前，有一点要铭记在心，ealsticsearch 有它自己的一套规范，
它只能搜索满足这套规范的数据集（姑且称为数据库），这样就涉及到了几个基本概念，例如 `index`， `type`，
`document` 等，具体的参考文档[查看这里](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/_basic_concepts.html)。

如果你使用过其它类型的数据库，比如说 mysql，就不难理解 elasticsearch 中的 index，type，document 这几个术语了。
index 类似于 mysql 中的数据库，type 相当于数据库中的一张表（table），而 document 则可以认为是表中的一条记录。
这样关于 index，type，document 三者之间的关系也一目了然了。一个 index 中可以有零或多个 type，
一个 type 中可以有成千上万条 document。

概念弄明白之后，就要实际操作了，假定我们想把一些用户信息存储到 elasticsearch 的数据库中，那到底如何操作呢？

首先要创建一个名字为 users 的 index，在命令行中执行：

~~~
$ curl -XPUT 'localhost:9200/users?pretty'
{
  "acknowledged" : true
}
~~~

若命令的输出结果如上所示，则说明成功创建了 users 索引。这里 `pretty` 参数是为了美化输出结果。
数据库建好之后，就可以填充数据了。注意填充数据的时候，要指定数据将要存储在哪一个 type 下，这里指定为 user ，执行

~~~
$ curl -XPUT 'localhost:9200/users/user/1?pretty' -d '
{
  "name": "Tom Lee",
  "intro": "a coder"
}'
~~~

输出如下：

~~~
{
  "_index" : "users",
  "_type" : "user",
  "_id" : "1",
  "_version" : 1,
  "created" : true
}
~~~

这样就在 users 索引中插入了一条用户信息，用户的 id 是1，若不指定 id 号，那 elasticsearch 会自动生成一个随机的 id 号。
那我们怎样得到刚才写入的用户信息呢，执行命令：

~~~
$ curl -XGET 'localhost:9200/users/user/1?pretty'
~~~

上述内容演示了 elsaticsearch 创建数据以及获取数据的功能，除此之外 elasticsearch 支持 REST API，还可以对数据进行删除，修改，搜索，排序等操作，功能很强大，
详细[参考文档](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/_exploring_your_cluster.html)。

### 在 Rails 应用中使用 Elasticsearch

下面介绍一下如何在 rails 应用中使用 elasticsearch，来体验 elasticsearch 的搜索功能。比如说有一个 rails
应用的名字为 esdemo, 作用是存储用户的一些信息（用户名 name 和 个人简介 intro），现在就要搜索这些用户信息，找到满足条件的用户。

首先在 Gemfile 文件中粘贴下面几行代码：

~~~
gem "elasticsearch", :git => "git://github.com/elasticsearch/elasticsearch-ruby.git"
gem "elasticsearch-model", :git => "git://github.com/elasticsearch/elasticsearch-rails.git"
gem "elasticsearch-rails", :git => "git://github.com/elasticsearch/elasticsearch-rails.git"
~~~

然后运行 `bundle install`, 安装新添加的 gem。通过这些 gem 提供的接口建立 rails 与 elasticsearch 之间的联系通道。

接下来在 `user_controller.rb` 文件新定义一个 `search` 方法，如下：

~~~
def search
  @users = User.search(
    query: {
      multi_match: {
        query: params[:q].to_s,
        fields: ['name', 'intro']
      }
    }
  ).records
end
~~~

这里就用到 elasticsearch 的搜索功能了，通过
[query language](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/_introducing_the_query_language.html)
来实现。这里的 `multi_match` [查询方式](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-queries.html)
可以选择搜索的字段，实例中搜索用户的名字和简介。

那如何获得要查询的关键字，则需要一个搜索框, 在 `index.html.erb` 模板文件中,
加入这些代码：

~~~
<%= form_tag search_users_path, method: 'get' do %>
  <%= text_field_tag :q, params[:q] %>
<% end %>
~~~

对应的 `route.rb` 中的代码是：

~~~
resources :users do
  collection { get :search }
end
~~~

现在搜索的核心代码已经介绍完了，但是不能使用，还需要索引数据，到 `lib/tasks` 目录下
新建一个名为 `elasticsearch.rake` 的文件，在文件中添加下面一行代码：

~~~
require 'elasticsearch/rails/tasks/import'
~~~

保存文件，重新启动 server，然后在命令行中执行任务：

~~~
$ bundle exec rake environment elasticsearch:import:model CLASS='User' FORCE=y
[IMPORT] Done
~~~

这样 users 这张表中的数据就导入到 elasticsearch 的 users 索引中了。打开浏览器，在地址栏中输入：

~~~
http://localhost:9200/users/user/1?pretty
~~~

就可以看到索引之后的数据格式了，这里显示的是用户 id 为1的用户信息，这条文档存储在 users 索引中的 user 类型下。

### 添加中文分词器 ik

Elasticsearch 默认使用的分词器是 standard，但是对中文的支持不准确。举个例子，如果要搜索 `中文`，我们期望的结果是包含
`中文`这个词组的匹配项，但 elasticsearch 会按单个字来匹配，出现很多无用的内容。解决这个问题的方法就是用更精确的中文分词器，
网上流行的是 ik，[源码地址](https://github.com/medcl/elasticsearch-analysis-ik)。ik 可以做为插件安装到 elastic 中。

首先要知道 elastic 的安装路径以及配置文件所在位置，在 Ubuntu 中运行命令：

~~~
dpkg -l | grep elasticsearch
~~~

这样就找到了与 elasticsearch 相关的所有文件了，[官方文档的默认配置](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup-service.html)，
安装路径为 `/usr/share/elasticsearch`，配置文件 `elasticsearch.yml` 所在的目录 `/etc/elasticsearch`

安装 ik 插件，插件名字 `elasticsearch-analysis-ik-1.2.6.jar`，
[下载地址](https://github.com/medcl/elasticsearch-rtf/blob/master/plugins/analysis-ik/elasticsearch-analysis-ik-1.2.6.jar)

~~~
cd ~/Download
wget https://github.com/medcl/elasticsearch-rtf/blob/master/plugins/analysis-ik/elasticsearch-analysis-ik-1.2.6.jar
~~~

ik 插件下载完毕后，只要把它复制到 `/usr/share/elasticsearch/plugins` 目录下，就可以了

~~~
sudo cp ~/Download/elasticsearch-analysis-ik-1.2.6.jar /usr/share/elasticsearch/plugins/
~~~

工作仍没完成，还得安装 ik 字典文件 ik.zip，[下载地址](http://github.com/downloads/medcl/elasticsearch-analysis-ik/ik.zip)

~~~
cd ~/Download
wget http://github.com/downloads/medcl/elasticsearch-analysis-ik/ik.zip
~~~

解压 ik.zip，并把解压后的目录文件复制到 `/etc/elasticsearch` 下，

~~~
unzip ik.zip
sudo cp -rf ik /etc/elasticsearch
~~~

为了让 ik 插件生效，还需要修改 elasticsearch 的配置文件，打开文件 `/etc/elasticsearch/elasticsearch.yml`，
在文件的最后，添加以下语句：

~~~
index:
  analysis:
    analyzer:
      ik:
        alias: [ik_analyzer]
        type: org.elasticsearch.index.analysis.IkAnalyzerProvider
      ik_max_word:
        type: ik
        use_smart: false
      ik_smart:
        type: ik
        use_smart: true
~~~

保存文件，然后重新启动 elasticsearch，才能使所有配置生效。

~~~
sudo service elasticsearch restart
~~~

下面用 elastic 的 API 测试一下，ik 插件其否安装成功了。先创建一个新的 index，名字为 test

~~~
$ curl -XPUT 'http://localhost:9200/test/'
{"acknowledged":true}
~~~

然后打开浏览器，访问下面的地址

~~~
http://localhost:9200/test/_analyze?analyzer=ik&text=中文分词&pretty
~~~

输出结果：

~~~
{
  "tokens" : [ {
    "token" : "中文",
    "start_offset" : 0,
    "end_offset" : 2,
    "type" : "CN_WORD",
    "position" : 1
  }, {
    "token" : "分词",
    "start_offset" : 2,
    "end_offset" : 4,
    "type" : "CN_WORD",
    "position" : 2
  } ]
}
~~~

若得到这样的结果，证明 ik 插件已经工作了。

### rails 中配置 ik 分词器

首先需要在 model 文件中配置数据的 mapping 方式，假定有一个 User model，那就需要在 user.rb 文件中添加这些代码：

~~~
settings index: { number_of_shards: 3 } do
  mappings do
    indexes :name,  type: 'string', index: "not_analyzed"
    indexes :intro, type: 'string', analyzer: 'ik'
  end
end
~~~

通过 `settings` 和 `mappings` 接口来设置用户的 intro 字段采用的分词器为 ik，
[参考文档](https://github.com/elasticsearch/elasticsearch-rails/tree/master/elasticsearch-model)。

保存文件，要重新索引数据，新的设置才能生效，运行命令：

~~~
$ bundle exec rake environment elasticsearch:import:model CLASS='User' FORCE=y
[IMPORT] Done
~~~

另外可以在 rails console 中查看某个 index 的 settings 和 mappings, 以 User model 为例：

~~~
rails c
User.settings
User.mappings
~~~

也可以通过 elastic 的 API 来查看，[get settings](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-get-settings.html)
和 [get mapping](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-get-mapping.html)，以 users index 为例：

~~~
curl -XGET 'http://localhost:9200/users/_settings?pretty'
curl -XGET 'http://localhost:9200/users/_mapping?pretty'
~~~

关于 elasticsearch 的基本使用就介绍这么多，更多需求请查阅文档。
