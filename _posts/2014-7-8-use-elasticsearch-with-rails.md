---
layout: post
title: Elasticsearch with rails
---

<!-- this deprecate ep#72 -->

在 <http://www.elasticsearch.org/case-study/github/> 上可以看到，github，stacketoverflow 和 basecamp 都在用 Elasticsearch(后面简称 es ) 。在 <http://happycasts.net/episodes/72> 中我介绍过 happycasts 当时的采用的搜索方案是 sunspot 和 solr 。但是对比一下 solr 和 es 的官网，一眼看出 [solr](http://lucene.apache.org/solr/) 是非常不关心 programmer happyness 的，而 [es](http://www.elasticsearch.org/) 的文档系统就非常贴心，还有很多精彩的视频。这两天，我已经把 happycasts 切换到了 es 。

这一期的 happycasts 来介绍一下在 ubuntu 1204 服务器上安装 es ，以及如何在 Rails 项目中使用 es 。

### 在 ubuntu 1204 上安装 elasticsearch

在安装 elasticsearch 之前，需要安装 Java 。

登陆到我在 linode 上新开的一个 ubuntu1204 服务器上

```
sudo apt-get update
sudo apt-get install openjdk-7-jre-headless
java -version
```

es 对 Java 版本的要求，见：
 <http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup.html> 中 “Java Version" 部分。



安装 elasticsearch 。下载地址是 <http://www.elasticsearch.org/overview/elkdownloads/>
这里有添加 apt 仓库的办法。 咱们就使用这个方法安装。我此刻，从安装时的信息可以看出 es 的版本是1.3.2。

apt-get 完成之后，启动 elasticsearch 服务：

~~~
sudo service elasticsearch start
~~~

设置开机就直接启动 es 服务：

~~~
sudo update-rc.d elasticsearch defaults 95 10
~~~

这样到我本地机器的 /etc/hosts 文件中，添加我的 linode ip 进来

```
xxx.xxx.xxx.xxx linode-esdemo
```

到浏览器，http://linode-esdemo:9200/ 看一下，显示如下信息，表示 es 已经可以工作了。
```
{
  "status" : 200,
  "name" : "Nico Minoru",
  "version" : {
    "number" : "1.3.2",
    "build_hash" : "dee175dbe2f254f3f26992f5d7591939aaefd12f",
    "build_timestamp" : "2014-08-13T14:29:30Z",
    "build_snapshot" : false,
    "lucene_version" : "4.9"
  },
  "tagline" : "You Know, for Search"
}
```

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
在我自己本地执行：

~~~
$ curl -XPUT 'linode-esdemo:9200/users?pretty'
{
  "acknowledged" : true
}
~~~

当然也可以在服务器上执行

```
$ curl -XPUT 'localhost:9200/users?pretty'
```

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

<http://joelabrahamsson.com/elasticsearch-101/>

### 在 Rails 应用中使用 Elasticsearch

https://github.com/elasticsearch/elasticsearch-rails

这里有一条命令创建 es demo 程序的。

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


### 高亮

<http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-request-highlighting.html>


### 参考

<http://railscasts.com/episodes/306-elasticsearch-part-1> 中介绍了如何在 Mac 系统上安装使用 es
