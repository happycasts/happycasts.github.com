---
layout: post
title: 基于 socket.io 实现协作编辑功能
---


今天要跟大家一起时间的功能很厉害，是一款协作编辑的实时性应用。我们同时打开两个浏览器，这样如果我在一个浏览器中去输入文本，会看到另外一个浏览器页面上也会实时的显示这样的修改，当然，如果我们把这个应用真正部署到服务器上，那么一个人去编辑，其他所有打开这个页面的人就都可以实时看到修改内容了，并且可以参与进来一起进行编辑，很多用过
google doc
的人对这个功能可能似曾相识，今天这期节目，咱们就一起动手来实现以下这个效果，主要用到了跑在
nodejs 之上的，大名鼎鼎的 socket.io，另外还引入了网页编辑器 codemirror 。


先看一眼 socket.io

![](http://happycasts.qiniudn.com/socketio.png)

<http://socket.io/get-started/chat/> 介绍了如果基于 nodejs 自己的 express
框架来搭建一个聊天室应用，代码非常的简约，最终的效果也是非常的惊艳，强烈建议初学者跟着弄一遍。


### 实际代码施工

首先要在自己的机器上安装 nodejs，我这里使用的是 Mac，打开终端，执行

``
$ node -v
v0.10.28
``

表示 nodejs 已经装好了。下面来新建一个 nodejs 的项目

``
mkdir coedit
cd coedit
npm init
``

这里要回答几个问题，基本都直接敲 Enter
保留默认值就可以了。具体每一个参数都是啥作用，可以参考：<https://www.npmjs.org/doc/json.html>

下面就安装 socket.io

``
npm install --save socket.io
``

这样，当前目录下会出现一个 `node_modules` 目录 socket.io
就装在这里了，`--save` 把 socket.io 的信息保存在了 `package.json`
中，这样以后部署项目时就很方便了。同时，一般的做法是不把 `node_modules`
中的内容存放到 git 中，所以如果你用 git，可以修改以下 .gitignore 文件。




服务器的基本框架我们用 nodejs 当下最流行的框架 express 来搭建，所以首先安装
express

``
npm install --save express
``

接下来创建 index.js 文件，先写入下面这些内容

``
var express = require('express');
var app = express();
var server = require('http').createServer(app);
var port = process.env.PORT || 3000;
var io = require('socket.io').listen(server);

server.listen(port, function () {
  console.log('Server listening at port %d', port);
});

app.get('/', function(req, res){
  res.send('<h1>Hello world</h1>');
});
``

这样，我们启动这个 express 应用，首先全局安装 nodemon

``
npm install -g nodemon
``

然后 `nodemon index.js` 这样就可以用流量器打开 `localhost:3000` 看到输出了。


### 使用 socket.io

socket.io 其实可以分为两部分，一部分是 socket.io
服务器，另一部分是客户端，我们先来写服务器代码。


添加这些内容到 index.js 就好了
``
var io = require('socket.io')(server);

io.on('connection', function(socket){
  console.log("user connected");
  socket.on('disconnect', function () {
      console.log("user left");
    });
});
``

下面准备添加客户端代码，所以我们首先需要添加页面模板进来，现在 index.js
添加这两行

``
app.set('views','./views/pages');
app.set('view engine','jade');
``
需要安装 jade

``
cd coedit/
npm install --save jade
``

然后更改原有的 `/` 路由代码

``
app.get('/',function(req,res){
  res.render('index',{
      title: 'coedit'
    });
});
``


views/pages/index.jade 中内容：

``
doctype
head
  meta(charset="utf-8")
  title #{title}
  script(src="https://code.jquery.com/jquery-1.10.2.min.js")
  script(src="/socket.io/socket.io.js")

body
  h1 Socket.io is Here
  script.
    var socket = io("localhost:3000");
``

### codemirror


codemirror 编辑器默认状态下就有很多快捷键的

`Ctrl/Cmd-x` 去删除一行


### 欢迎大家参与开发

今天这期视频的代码放在这个 repo 里了：
<xxx>，这个咱们以后就不会改动了，不过我确实觉得这个功能会有一些实际的用处，比如开会定方案或是搞向上教学等等，所以我专门建了一个
repo
<https://github.com/happypeter/happyedit>，这个欢迎大家参与到开发，不断丰富一些功能进来。<https://github.com/happypeter/happyedit/graphs/contributors>
目前是我们三个都贡献了一些代码进来。


