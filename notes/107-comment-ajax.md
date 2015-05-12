<!-- css-tricks 样式的评论，评论一张小狗图片 -->
ajax 听起来好复杂呀？其实用起来就没啥了，就是再不刷新页面的情况下，去服务器上加载新的内容过来。比如这里有一个照片，下面可以添加评论。没有 ajax 化的基本评论功能是这样的，你点击发布，页面会整个刷新，搞得用起来很不舒服。但是如果 ajax 化之后，就会有更为平滑的用户体验了，帅吧？这里咱们就是要来在 Rails4 应用中做出这个效果来。

本期是第66期的改良版。源码在 <https://github.com/happycasts/episode-107-demo> 。 css 样式参考了 Css-tricks.com 。

![](http://media.haoduoshipin.com/pic/happycasts/ajax_comment.png)

### 下载代码
到 <https://github.com/happycasts/episode-107-demo> 下载代码之后，里面有一个 before 目录是咱们这集的起点，after 中是最终的效果。

把 before 拷贝到 ubuntu 系统之中，重命名为 dogs

    cd dogs
    bundle
    vim config/database.yml 填入你自己的 mysql 数据库的密码
    rake db:setup
    rails s

我在 seed.rb 文件中已经填充了一些数据，所以首页上就可以看到小狗们的列表了。关于我本地虚拟机的搭建可以参考 <http://haoduoshipin.com/episodes/105>

### 把过程 ajax 化
普通的请求，后台 log 中请求的格式是 HTML。要变 Ajax 请求，就到 _comment_box.html.erb 文件中

```erb
- <%= form_tag "/dogs/#{dog.id}/comments", method: :post do %>
+ <%= form_tag "/dogs/#{dog.id}/comments", method: :post, remote: 'true' do %>
```

打开生成的 html 发现就是多个 `data-remote: true` 。 那 ajax 请请求谁来发？ <https://github.com/rails/jquery-ujs> 帮我搞定一切，不必操心，打开 application.js 有对它的 require 。现在再来看后台，请求的格式就是 js 了。

对应的，要到 dogs_controller.rb 中

```ruby
- dog = Dog.find(params[:id])
- redirect_to "/dog/#{dog.id}"
+ respond_to do |format|
+   format.html {
+     dog = Dog.find(params[:id])
+     redirect_to "/dog/#{dog.id}"
+   }
+   format.js
+ end
```

添加 app/views/dogs/create_comment.js.erb 文件。先来添加一条测试语句

```js
console.log('I am working!');
```

但是我真正想要的效果是添加一条评论进来。

```js
console.log('I am working!');
$(".comments").append("<%= j render partial: 'comment', locals: {comment: @comment} %>");
$(".comment-box textarea, .commenter-info input").val('');
```

这样，提交过程就 ajax 化了。

### 使用 chrome 来调试 ajax 功能
如果 .js.erb 中 ruby 代码写错了（比如 `render` 写成了 `reender` ）。可以到 devtools -> Network 重启发一下请求，这样点击请求结果，可以看到报错信息了。

但是如果就是 js 代码写错了(比如 `before` 写成了 `beforee` )，那后台 log 可就没有报错信息了。这时候也可以到 Network 标签下，查看请求结果，把得到的 js 在 devtools 的 console 中执行一下，这时候问题就会体现的比较明显了。

不使用 Rails 的这一套，还有 http://api.jquery.com/jquery.ajax/ 这这样的接口可以使用。