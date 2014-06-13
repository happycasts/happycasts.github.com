---
layout: post
title: 实时之王 Socket.io
---

好的，我是一个 Rails 程序员，但是 Nodejs 的世界里确实有我们值得学习的地方。

如果你想要一个简单易用，同时有跨浏览器兼容非常好的的文字聊天功能，那么 socket.io 应该是当下最流行的解决方案。socket.io 可以支持双向通信，这就意味着服务器不再是被动的去相应请求，而是可以主动的去给浏览器发送信息了，并且是基于事件的，实时的。我自己用了一下，确实有眼前一亮，相见恨晚的感觉。眼见为实，咱们一起动手搭建一下。要用到的技术主要就是跑在 nodejs 之上的 socket.io，数据存储用 Redis，然后在咱们给的例子里面在稍微看一下，nodejs 如何和 Rails 协同工作。

说一句跨平台兼容。就像在官网上我们看到的 “It works on every platform, browser or device, focusing equally on reliability and speed.”，在支持 html5 的浏览器上，socket.io 使用 websocket 能够获得最好的体验。到比较老的浏览器上也会有 fallback 机制，所以大家不必为此担心。

<http://socket.io/get-started/chat/> 介绍了如果基于 nodejs 自己的 express 框架来搭建一个聊天室应用，代码非常的简约，最终的效果也是非常的惊艳，强烈建议初学者跟着弄一遍。	不过今天的例子咱们基于 Rails 来作。整套思路受这篇文章启发很大 <http://liamkaufman.com/blog/2013/02/27/adding-real-time-to-a-restful-rails-app/>

### 第一步，nodejs 和 rails

在我的 Linux(ubuntu 14.04) 之上，安装 nodejs，这里有 DigitalOcean 的一篇文章推荐给大家 <https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server>，插一句啊，DigtalOcean 类似这种的文章还有很多，都是简单实用料很足啊，大家可以多多参考。具体的安装步骤我们这里就不演示了，没有什么问题，而且咱们今天的这个 demo 项目对 node 的版本也没有特殊的要求。我自己是用的添加 ppa 的那种形式。

~~~
$ node -v
$ 0.10.28
~~~

如果能看到类似于上面的输出，表示 Nodejs 已经装好了，下面我们来创建一个简单的 Rails 程序

~~~
$ rails new chatroom -d mysql
~~~



在我们去生成 rails 的 controller 代码的时候，不要忘了在 application.rb 中添加	

```
config.generators do |g|
  g.assets false
  g.helper false
  g.test_framework false
end
```

这样可以避免 Rails 自作聪明的帮我们生成一些我们暂时用不到的文件。现在运行

~~~
rails g controller chatroom show
~~~



### 第二幕，主角登场

我们可以先到 socket.io 的官网上看一下：

![](http://happycasts.qiniudn.com/socketio.png)


来到 <http://socket.io/docs/> ，安装就是简单地 `$ npm install socket.io` 就可以了，不过咱们不这么弄，先新建个 Nodejs 的项目，然后在项目的 package.json 文件中去指定更方便。

进入 chatroom ，然后运行：

~~~
mkdir realtime
cd realtime
npm init
~~~

随之，我们要回答几个问题，填入几个参数，具体每一个参数都是啥作用，可以参考：https://www.npmjs.org/doc/json.html
然后，我们可以打开 package.json 这个文件，删掉 `scripts` 这一项，因为咱们这个项目里用不着，

~~~
npm install --save socket.io
~~~

`--save` 可以把 socket.io 写入 package.json 的包依赖中，以后项目要部署就直接用 `npm install` 直接装了。


~~~
npm install -g nodemon
~~~

`-g` 的意思是全局安装，如果一个包里面有可执行的系统命令，就应该用这个参数来安装。


### Rails 项目中安装 socket.io 的客户端

其实所谓的 socket.io 到底是啥？两个部分：一个是运行在服务器上的代码，另一部分是运行到用户浏览器上的代码。这两部分遥相呼应，我们的这个浏览器到服务器的双向信息高速公路就开通了。


这个安装客户端的过程其实非常简单，就是在页面中添加一个 js 文件就可以了，所以我们可以来到 `realtime/node_modules/socket.io/node_modules/socket.io-client/` 目录中，找到客户端代码 `socket.io.js` ，然后放到我们的 rails 项目中的合适位置，也就是 `chatroom/lib/assets/javascripts/` 目录下。然后可别忘了到 `application.js` 文件中添加这一行

~~~
//= require socket.io
~~


### Redis


Redis 的数据组织可是跟 SQL 的数据库差别很大，参考 http://redis.io/topics/twitter-clone 。


所以这里 Redis 起到了一个连接作用，socket.io 起到了读写作用，Rails 的作用就只是读取数据，然后自己进行分析。类似的一个例子 <https://devcenter.heroku.com/articles/realtime-polyglot-app-node-ruby-mongodb-socketio> 使用 mongodb 作为连接。
