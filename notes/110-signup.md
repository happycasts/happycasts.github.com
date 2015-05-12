在 [第84期](http://haoduoshipin.com/episodes/84) 中介绍了如果手写用户的登录和注册模块。当然那时用的是 Rails3
今天这期是84期的改进版，在 Rails4 下作。而且拆成两集：本期讲注册，下一期讲验证和报错。

这一期视频完成结果的代码放在 [这里了](https://github.com/happycasts/episode-110-demo)。

来看看 rails 版本：

    rails -v
    4.1.2

### 创建项目

新建一个 rails4 应用

    rails new baby -d mysql

添加简化 rails generator 的配置，到 application.rb 中添加

```ruby
config.generators do |g|
  g.assets false
  g.helper false
  g.test_framework false
end
```

创建数据库

    rake db:create db:migrate

创建 user 的 model 和数据表字段：

    rails g model user name:string email:string password_digest:string token:string

然后要运行

    rake db:migrate

再来生成 controller 和 view 模板

    rails g controller users welcome signup login

route.rb 中这样写

```ruby
Rails.application.routes.draw do
  root to: "users#welcome"
  get "login" => "users#login", :as => "login"
  get "signup" => "users#signup", :as => "signup"
  post "create_login_session" => "users#create_login_session"
  delete "logout" => "users#logout", :as => "logout"
  resources :users, only: [:create]
end
```

到 application.html.erb 中添加

```erb
<%= render 'shared/header' %>
```

`shared/_header.html.erb` 的内容

```erb
<div class="header">
  <div class="container clearfix">
    <a class="header-logo-wordmark" href="/">
      HOME
    </a>
    <ul id="user-links">
      <li><%= link_to "注册", signup_path %></li>
      <li><%= link_to "登录", login_path %></li>
    </ul>
  </div>
</div>
```

css 这里就不帖了，可以到 [github 仓库](https://github.com/happycasts/episode-110-demo) 中下载。

### 添加注册功能

users_controller.rb 中，signup 方法里填写

```ruby
@user = User.new
```

对应 signup.html.erb 是这些内容

```erb
<div class="single-form-container">
  <%= form_for @user do |f| %>
    <div class="boxed-group">
      <h3>注册</h3>
      <div class="boxed-group-inner">
        <dl class="form">
          <dt><%= f.label :name %></dt>
          <dd><%= f.text_field :name %></dd>
        </dl>
        <dl class="form">
          <dt> <%= f.label :email %></dt>
          <dd> <%= f.text_field :email %> </dd>
        </dl>
        <dl class="form">
          <dt> <%= f.label :password %> </dt>
          <dd> <%= f.password_field :password %> </dd>
        </dl>
        <dl class="form">
          <dt> <%= f.label :password_confirmation %> </dt>
          <dd> <%= f.password_field :password_confirmation %> </dd>
        </dl>
        <p><%= f.submit "注册", :class => "button primary" %></p>
      </div>
    </div>
  <% end %>
</div>
```

表单填写的数据要提交到 users_controller.rb 中的 create 方法

```ruby
def create
  @user = User.new(user_params)
  if @user.save
    cookies.permanent[:token] = @user.token
    redirect_to :root
  else
    render :signup
  end
end

private
  def user_params
    params.require(:user).permit!
  end
```

代码中又 `@user.token` 所以还需要添加生成认证令牌 token 的代码，到 user.rb 文件

```ruby
before_create { generate_token(:token) }

def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
end
```

同时还要使用 `has_secure_password`，也就是要在 user.rb 中再添加

```ruby
has_secure_password
```

再到 Gemfile 中

```ruby
- # gem 'bcrypt', '~> 3.1.7'
+ gem 'bcrypt', '~> 3.1.7'
```

不要忘记运行 bundle 和重启服务器。这样新用户就可以成功注册了。

### 保持登陆状态

这时候可以到 chrome devtools -> resources 下查看 cookie，发现本地已经保存了 token 。所以可以用它来保持登陆状态。

到 application_controller.rb 中

```ruby
def current_user
  @current_user ||= User.find_by_token(cookies[:token]) if cookies[:token]
end

helper_method :current_user
```

到 `shared/_header.html.erb` 中，修改一下

```erb
<% if current_user %>
  <li><%= link_to current_user.name, '#' %></li>
  <li><%= link_to "退出", logout_path, method: "delete" %></li>
<% else %>
  <li><%= link_to "注册", signup_path %></li>
  <li><%= link_to "登录", login_path %></li>
<% end %>
```

这样在来刷新页面，就看到了登陆用户的用户名了。

不够 logout 按钮还不管用，所以来添加一下，到 users_controller.rb 中，添加

```ruby
def logout
  cookies.delete(:token)
  redirect_to root_url
end
```

### 登录页面

login.html.erb 中添加

```erb
<div class="single-form-container">
  <div class="boxed-group" id="login">
    <h3>登录</h3>
    <div class="boxed-group-inner">
      <%= form_tag "/create_login_session" do %>
        <dl class="form">
          <dt>
         <%= label_tag "用户名" %>
          </dt>
          <dd>
          <%= text_field_tag :name, params[:name] %>
          </dd>
        </dl>
        <dl class="form">
          <dt>
          <%= label_tag "密码" %>
          </dt>
          <dd>
          <%= password_field_tag :password, params[:password] %>
          </dd>
        </dl>
        <p> <%= submit_tag "登录", :class => "button primary" %> </p>
      <% end %>
    </div>
  </div>
</div>
```

users_controller.rb 中添加

```ruby
def create_login_session
  user = User.find_by_name(params[:name])
  if user && user.authenticate(params[:password])
    cookies.permanent[:token] = user.token
    redirect_to root_url
  else
    redirect_to :login
  end
end
```

这里，就可以登录成功了。这一集就到这里，下一集介绍表单验证和报错信息处理。