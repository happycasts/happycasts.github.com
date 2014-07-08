---
layout: post
title: Elasticsearch with rails (work in process)
---

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

以上信息来源请参考 [elasticsearch setup](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup.html)。

另外，如果你想使用 OpenJDK 也是可以的，运行的安装命令是（本人采用的方法）：

~~~
sudo apt-get install openjdk-7-jre
~~~

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
### elasticsearch basic usage

elasticsearch 安装成功之后，就要使用它了。在使用 elasticsearch 之前，最好先了解几个基本概念，例如 `index`, `type`,
`document` 等，可以查看这里
<http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/_basic_concepts.html>

### use elasticsearch with rails

下面介绍一下如何在 rails 应用中使用 elasticsearch。比如说这个 rails
应用的名字为 esdemo,
作用是存储用户的一些信息（用户名和个人简介），现在就要搜索这些用户信息，找到满足条件的用户。

首先在 Gemfile 文件中粘贴下面几行代码：

~~~
gem "elasticsearch", :git => "git://github.com/elasticsearch/elasticsearch-ruby.git"
gem "elasticsearch-model", :git => "git://github.com/elasticsearch/elasticsearch-rails.git"
gem "elasticsearch-rails", :git => "git://github.com/elasticsearch/elasticsearch-rails.git"
~~~

然后运行 `bundle install`, 安装新添加的 gem。

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

通过 elasticsearch 的 `multi_match` 查询类型可以选择搜索的字段，这里只是搜索用户的名字和简介。

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

现在搜索的核心代码已经介绍完了，但是不能使用，还需要在命令行中运行一个命令：

~~~
 bundle exec rake environment elasticsearch:import:model CLASS='User' FORCE=y
~~~

这个命令的作用是索引 users 这张表，elasticsearch 只会查找索引之后的 users
数据，而不是 users 这张表中的数据。 打开浏览器，在地址栏中输入：

~~~
http://localhost:9200/users/user/1?pretty 
~~~

就可以看到索引之后的数据格式了，这里显示的是用户 id 为1的用户信息，这条文档存储在 users 索引中的 user 类型下。
