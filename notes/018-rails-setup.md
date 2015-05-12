__Resources:__

- <http://rubyonrails.org/>
- <http://rvm.io>

~~~
curl -L get.rvm.io | bash -s stable
source /home/peter/.rvm/scripts/rvm
rvm requirements
~~~

~~~
sudo /usr/bin/apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion
rvm install 1.9.3
rvm list
rvm use 1.9.3 # select and use 1.9.3, not needed if you only have one ruby
rvm 1.9.3 --defualt # set 1.9.3 to be default, not needed if you have only one ruby
gem install rails
~~~

~~~
rails new blog -d mysql
sudo apt-get install libmysqlclient-dev
~~~

~~~
gem 'therubyracer'
~~~

~~~
sudo apt-get install mysql-server
rake db:create
~~~

~~~
cd public/
rm index.html
rails g scaffold blog name:string
rake db:migrate
~~~

~~~
  root :to => 'blogs#index'
~~~

~~~
sudo apt-get install apache2
gem install passenger
passenger-install-apache2-module
~~~

~~~
LoadModule passenger_module /home/peter/.rvm/gems/ruby-1.9.3-p125/gems/passenger-3.0.12/ext/apache2/mod_passenger.so
PassengerRoot /home/peter/.rvm/gems/ruby-1.9.3-p125/gems/passenger-3.0.12
PassengerRuby /home/peter/.rvm/wrappers/ruby-1.9.3-p125/ruby

   <VirtualHost *:80>
      ServerName www.yourhost.com
      # !!! Be sure to point DocumentRoot to 'public'!
      DocumentRoot /home/peter/my_blog/public/
      RailsEnv development 
      <Directory /home/peter/my_blog/public/ >
         # This relaxes Apache security settings.
         AllowOverride all
         # MultiViews must be turned off.
         Options -MultiViews
      </Directory>
   </VirtualHost>
~~~

~~~
sudo apachectl graceful
~~~

~~~
sudo vim /etc/hosts
# /etc/hosts
127.0.0.1 www.yourhost.com
~~~