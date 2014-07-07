---
layout: post
title: Elastic Search ( Work In Progress )
---

### 在 ubuntu 1204 上安装 elasticsearch（最新版本 1.2.1）

在安装 elasticsearch 之前，需要安装 Java, 高版本的 elasticsearch 至少需要 Java 7 才能运行。
需要注意一下，官方文档上推荐使用的是 Oracle JDK，而 Ubuntu 因版权问题默认支持的是 OpenJDK
但你自己可以手动安装 Oracle JDK，在命令中执行以下操作:

~~~
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
java -version
~~~

最后一步操作 `java -version` 可以查看所安装的 JDK 的版本是否正确。

以上信息来源请参考 [elasticsearch setup](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup.html)。

另外，如果你想使用 OpenJDK 也是可以的，运行的安装命令是：

~~~
sudo apt-get install openjdk-7-jre
~~~

接下来要做的工作就是下载 elasticsearch，下载地址是 <http://www.elasticsearch.org/overview/elkdownloads/>，这里提供了
几种不同类型的安装包，从中选择 debian 安装包 <https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb>。

下载完毕之后，就需要安装了，运行命令：

~~~
sudo dpkg -i elasticsearch-1.2.1.deb
~~~

启动 | 停止 | 重新启动 elasticsearch 服务：

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

或者是打开浏览器，访问本地端口 `http://localhost:9200`，看到如下内容，说明 elasticsearch 已经成功运行起来了

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
