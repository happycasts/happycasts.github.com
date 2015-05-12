- [Code](https://github.com/happycasts/episode-84-demo)

~~~
rails new baby -d mysql
~~~

~~~
    config.generators do |g|
        g.assets false
        g.helper false
        g.test_framework false
    end
~~~

~~~
rake db:create;rake db:migrate
rails g model user name:string email:string password_digest:string token:string
rake db:migrate
rails g controller users welcome signup login
~~~

~~~
Signup::Application.routes.draw do
  root to: "users#welcome"
  get "login" => "users#login", :as => "login"
  get "signup" => "users#signup", :as => "signup"
  post "create_login_session" => "users#create_login_session"
  delete "logout" => "users#logout", :as => "logout"
  resources :users, only: [:create]
end
~~~

~~~
rm public/index.html.erb
rails s
~~~

~~~
class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation, :token
  before_create { generate_token(:token) }

  validates :name, :presence => true, :uniqueness => {:case_sensitive => false}
  validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :email_format => true
  validates :password, :length => { :minimum => 6 }, :on => :create

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
~~~

~~~
#encoding: utf-8
class UsersController < ApplicationController
  def welcome
  end

  def signup
    @user = User.new
  end

  def login
  end

  def create_login_session
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      cookies.permanent[:token] = user.token
      redirect_to root_url, :notice => "登录成功"
    else
      flash[:error] = "无效的用户名和密码"
      redirect_to :login
    end
  end

  def logout
    cookies.delete(:token)
    redirect_to root_url, :notice => "已经退出登录"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies.permanent[:token] = @user.token
      redirect_to :root, :notice => "注册成功"
    else
      render :signup
    end
  end
end
~~~

~~~
<div class="single-form-container">
  <%= form_for @user do |f| %>
    <div class="boxed-group">
      <h3>注册</h3>
      <div class="boxed-group-inner">
        <% if @user.errors.any? %>
          <div class="form_errorred">
            填写的信息有误
          </div>
        <% end %>
        <dl class="form">
          <dt><%= f.label :name %></dt>
          <dd><%= f.text_field :name %></dd>
          <% if @user.errors[:name].any? %>
            <dd class="error"><%= @user.errors[:name][0] %></dd>
          <% end %>
        </dl>
        <dl class="form">
          <dt> <%= f.label :email %></dt>
          <dd> <%= f.text_field :email %> </dd>
          <% if @user.errors[:email].any? %>
            <dd class="error"><%= @user.errors[:email][0] %></dd>
          <% end %>
        </dl>
        <dl class="form">
          <dt> <%= f.label :password %> </dt>
          <dd> <%= f.password_field :password %> </dd>
          <% if @user.errors[:password].any? %>
            <dd class="error"><%= @user.errors[:password][0] %></dd>
          <% end %>
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
~~~