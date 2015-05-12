---
layout: shownote
title: Devise
---
本期视频由李宗晟同学为大家倾情奉献，大家可以通过他的邮箱 <lizongshenglzs@gmail.com> 联系到他。谢谢宗晟的辛勤劳动！

- <https://github.com/plataformatec/devise>
- <http://www.railstutorial.org/>


~~~
$rails new airbnb
$cd  airbnb
$rails g scaffold House location:string price:integer 
$rake db:create db:migrate
~~~

~~~
gem 'devise'
~~~


~~~
$rails g devise:install
~~~


~~~
config.action_mailer.default_url_options = { host: 'localhost:3000' } into 
~~~


~~~
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
~~~


~~~
$rails generate devise User 
rake db:migrate
~~~

~~~
before_action :authenticate_user!
~~~

~~~
<% if user_signed_in? %>
  Logged in as <strong><%= current_user.email %></strong>.
  <%= link_to 'Edit profile', edit_user_registration_path %> |
  <%= link_to "Logout", destroy_user_session_path, method: :delete %>
<% else %>
  <%= link_to "Sign up", new_user_registration_path %> |
  <%= link_to "Login", new_user_session_path %>
<% end %>
~~~


~~~
config.action_mailer.perform_deliveries = true 
config.action_mailer.raise_delivery_errors = true 
config.action_mailer.delivery_method = :smtp
 config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'chuochuo.me',
    user_name:            'email@gmail.com',
    password:             'password',
    authentication:       'plain',
    enable_starttls_auto: true  }
~~~

