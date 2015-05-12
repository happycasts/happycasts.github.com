今天要跟大家一起实现的功能很厉害，是一款协作编辑的实时性应用。我们同时打开两个浏览器，这样如果我在一个浏览器中去输入文本，会看到另外一个浏览器页面上也实时的显示这样的修改。当然，如果我们把这个应用部署到服务器上，那么一个人去编辑，互联网上其他打开这个页面的人就都可以实时看到修改内容了，并且可以参与进来一起进行编辑。很多用过
google docs 的人对这个功能可能似曾相识。今天这期节目，咱们就一起动手来实现这个功能，主要用到了跑在
nodejs 之上的大名鼎鼎的 socket.io，另外还使用了网页编辑器 Codemirror 。

先看一眼 socket.io，它是一套浏览器兼容性非常好的 web 实时通讯 js 库。

![](http://media.haoduoshipin.com/pic/happycasts/socketio.png)

<http://socket.io/get-started/chat/> 介绍了如果基于 express 框架来搭建一个聊天室应用，代码非常的简约，最终的效果也是非常的惊艳，强烈建议初学者跟着弄一遍。

# 初始化一个 nodejs 项目

![](http://media.haoduoshipin.com/pic/happycasts/nodejs.jpg)

首先要在自己的机器上安装 nodejs，这里我们就不演示了。我这里使用的是 Mac，可以使用 Homebrew 来安装。打开终端，执行

~~~
node -v
v0.10.28
~~~

表示 nodejs 已经装好了。下面来新建一个 nodejs 的项目

~~~
mkdir coedit
cd coedit
npm init
~~~

这里要回答几个问题，基本都直接敲 Enter 保留默认值就可以了。具体每一个参数都是啥作用，可以参考：<https://www.npmjs.org/doc/json.html>

下面就安装 socket.io

~~~
npm install --save socket.io
~~~

这样，当前目录下会出现一个 `node_modules` 目录 socket.io
就装在这里了，`--save` 把 socket.io 的信息保存在了 `package.json`
中，这样以后部署项目时就很方便了。同时如果你用 git，一般的做法是不把 `node_modules`
中的内容 commit 到源码仓库中，所以需要把 `node_modules` 添加到 .gitignore 文件。

服务器我们用 nodejs 当下最流行的框架 express 来搭建，所以首先安装
[express](http://expressjs.com/) 。

~~~
npm install --save express
~~~

![](http://media.haoduoshipin.com/pic/happycasts/expressjs.png)

接下来创建 index.js 文件，先写入下面这些内容

```javascript
var express = require('express');
var app = express();
var server = require('http').createServer(app);
var port = process.env.PORT||3000;

server.listen(port, function(){
  console.log('Server listening at port %d', port);
});

app.get('/', function(req, res){
  res.send('<h1>Hello world</h1>');
});
```

接下来，全局安装 nodemon

~~~
npm install -g nodemon
~~~

然后 `nodemon index.js` 启动我们的应用，这样就可以用浏览器打开 `localhost:3000` 看到我们搭建好的这个网站了。

# 配置 socket.io

socket.io 其实可以分为两部分，一部分是 socket.io
服务器，另一部分是客户端，我们先来写服务器代码。

添加这些内容到 index.js 就好了

```javascript
var io = require('socket.io')(server);

io.on('connection', function(socket){
  console.log("user connected");
  socket.on('disconnect', function(){
    console.log("user left");
  });
});
```

在添加客户端代码之前，我们有一些准备工作要做。首先需要添加页面模板进来。 index.js
添加这两行

```javascript
app.set('views','./views/pages');
app.set('view engine','jade');
```

相应的需要安装 jade，一种类似于 Haml 的简化 html 书写的小语言

![](http://media.haoduoshipin.com/pic/happycasts/jade.png)

~~~
cd coedit/
npm install --save jade
~~~

然后，更改原有的 `/` 路由代码

```javascript
app.get('/',function(req,res){
  res.render('index',{
      title: 'coedit'
    });
});
```

添加 views/pages/index.jade 文件，其中内容：

```jade
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
```

这样，所谓的 socket.io 的客户端部分就搭建好了。每次打开这个页面，我们到 `nodemon index.js` 运行的终端，就可以看到 `user connected` 的这样的 log 信息，关闭页面，会看到 `user left`，这就表明，服务器和浏览器之间的这条实时通讯的高速公路已经开通了。

# 使用 socket.io 传递数据

下面看看如果从服务器发送信息到各个客户端：

服务器端代码：

```javascript
var body = "type in text";
socket.emit('refresh', {body: body});
```

浏览器端，也就是 index.jade 中要添加的响应代码是

```javascript
socket.on('refresh', function(data){
  $('h1').text(data.body);
});
```

这里的模式是明显的，用 `emit` 发出一个事件，另一端用 `on` 来相应。从浏览器向服务器发送信息也是相同的，不过在做这部分的演示之前，我们先来安装 Codemirror.

# 浏览器中的编辑器 Codemirror

需要在 index.jade 中的 `head` 标签下，添加如下的内容

```jade
// codemirror begin
link(rel='stylesheet', href='http://codemirror.net/lib/codemirror.css')
link(rel='stylesheet', href='http://codemirror.net/theme/ambiance.css')
script(src='http://codemirror.net/lib/codemirror.js')
script(src='http://codemirror.net/addon/mode/overlay.js')
script(src='http://codemirror.net/mode/markdown/markdown.js')
//  codemirror end
```

接下来 `body` 标签下添加

```jade
textarea#textbox

script.
  var editor = CodeMirror.fromTextArea(document.getElementById("textbox"), {
    mode: 'markdown',
    lineNumbers: true,
    theme: "ambiance"
  });
```

上面的代码把页面上的编辑器设置为 markdown
模式。打开浏览器页面，我们操作一下，发现可以对 markdown
的各种语法要素给予不同的字体颜色的（这里颜色主题设置为 "ambiance"，codemirror
网站上还有很多很好看的主题可以选用）。

这样，我们前面的 `$('h1').text(data.body);` 这条语句就可以改为
`editor.setValue(data.body);` 原来的那个 `h1` 标签也可以删掉了。

另外 codemirror 编辑器默认状态下就有很多快捷键的，例如 `Ctrl/Cmd-x`
去删除一行文本。

下面我们来捕捉文本修改的事件，来添加这些代码

```jade
script.
  editor.on('change', function(i, op){
    socket.emit('change', op);
  });
```

然后，`socket.emit('change', op);` 可以把这些内容发送到服务器上，那么在
index.js 中，我们添加如下代码来接收这些数据：

```javascript
socket.on('change', function(op){
  console.log(op);
  if (op.origin == '+input' || op.origin == 'paste' || op.origin == '+delete') {
    socket.broadcast.emit('change', op);
  };
});
```

做一下实验，如果我们在浏览器中做一下修改，那么 `console.log(op)`
就可以帮我们打印出 `op` 的具体内容

~~~
{ from: { line: 0, ch: 2 },
  to: { line: 0, ch: 3 },
  text: [ '' ],
  removed: [ 'p' ],
  origin: '+delete' }
~~~

这里，服务器把我做的修改拿到，然后 `broadcast`
到了其他所有人，那么大家的浏览器拿到 `op`
的这些修改信息，就需要对页面做相应的更新，这样才能看到我的修改，具体代码就是要在
index.jade 中添加

```jade
socket.on('change', function(data){
  console.log(data);
  editor.replaceRange(data.text, data.from, data.to);
});
```

协同编辑功能就完成了。

# 欢迎大家参与开发

今天这期视频的代码放在这个 repo 里了： <https://github.com/happycasts/episode-99-demo> 。这个以后就不会改动了，不过我确实觉得这个功能会有一些实际的用处，比如开会定方案或是搞教学等等，所以我专门建了一个项目
 [happyedit](https://github.com/happypeter/happyedit) ，欢迎大家参与开发，不断丰富一些功能进来。
目前是 billie，qichunren 和我 [三个人](https://github.com/happypeter/happyedit/graphs/contributors) 都贡献了一些代码。