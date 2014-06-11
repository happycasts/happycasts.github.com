---
layout: post
title: 实时之王 Socket.io
---

好的，我是一个 Rails 程序员，但是 Nodejs 的世界里确实有我们值得学习的地方。

如果你想要一个简单易用，同时有跨浏览器兼容非常好的的文字聊天功能，那么 socket.io 应该是当下最流行的解决方案。我自己用了一下，确实有眼前一亮，相见恨晚的感觉。眼见为实，一起动手搭建一下。要用到的技术主要就是跑在 nodejs 之上的 socket.io，数据存储咱们用 Redis，然后在咱们给的例子里面在稍微看一下，nodejs 如何和 Rails 协同工作。

### 第一步，nodejs

在我的 Linux(ubuntu 14.04) 之上，安装 nodejs，这里有 DigitalOcean 的一篇文章推荐给大家 <https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server>，插一句啊，DigtalOcean 类似这种的文章还有很多，都是简单实用料很足啊，大家可以多多参考。具体的安装步骤我们这里就不演示了，没有什么问题，而且咱们今天的这个 demo 项目对 node 的版本也没有特殊的要求。我自己是用的添加 ppa 的那种形式。

~~~
$ node -v
$ 0.10.28
~~~



### 第二幕，主角登场

我们可以先到 socket.io 的官网上看一下：

![](http://happycasts.qiniudn.com/socketio.png)


来到 <http://socket.io/docs/> ，安装就是简单地 `$ npm install socket.io` 就可以了，不过咱们不这么弄，先新建个 Nodejs 的项目，然后在项目的 package.json 文件中去指定更方便。

我们来创建一个项目目录叫做 happytime，跳转到目录之中，然后运行：

~~~
npm install
~~~

随之，我们要回答几个问题，填入几个参数，具体每一个参数都是啥作用，可以参考：https://www.npmjs.org/doc/json.html
然后，我们可以打开 package.json 这个文件，删掉 `scripts` 这一项，因为咱们这个项目里用不着，

~~~
npm install --save socket.io@1.0.3
~~~

`--save` 可以把 socket.io 写入 package.json 的包依赖中，以后项目要部署就直接用 `npm install` 直接装了。


~~~
npm install -g nodemon
~~~

`-g` 的意思是全局安装，如果一个包里面有可执行的系统命令，就应该用这个参数来安装。

### Redis


Redis 的数据组织可是跟 SQL 的数据库差别很大，参考 http://redis.io/topics/twitter-clone 。