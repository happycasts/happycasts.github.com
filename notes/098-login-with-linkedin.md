参考资料：

* http://railscasts.com/episodes/360-facebook-authentication

* https://github.com/decioferreira/omniauth-linkedin-oauth2

申请 API key 的地址链接:

* https://www.linkedin.com/secure/developer

项目源码:

* https://github.com/happycasts/episode-98-demo

~~~
gem 'omniauth-linkedin-oauth2'
~~~

~~~
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
end
~~~

~~~
get "/auth/:provider/callback", to: "users#create"
get "/auth/failure", to: redirect("/")

delete "signout", to: "users#destroy", as: "signout"
root "users#index"
~~~

~~~
class User < ActiveRecord::Base
  def self.from_auth(auth)
    User.where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email =  auth.info.email
      user.avatar = auth.info.image
    end
  end
end
~~~

~~~
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    user = User.from_auth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
~~~

~~~
<div class="nav">
   <% if current_user %>
     <%= image_tag current_user.avatar, size: "30x30" %>
     <strong><%= current_user.name %></strong>
     <%= link_to "退出", signout_path, :method => :delete %>
   <% else %>
     <%= link_to "Linkedin 账户登录", "/auth/linkedin" %>
   <% end %>
</div>
~~~

~~~
private

def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
helper_method :current_use
~~~