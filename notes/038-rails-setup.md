- <http://railscasts.com/?tag_id=21>
- [rbenv installer](https://github.com/fesplugas/rbenv-installer)

### 1. 装包

~~~
sudo apt-get update
sudo adduser deployer --ingroup sudo
sudo apt-get -y install git-core
sudo apt-get -y install libmysqlclient-dev
sudo apt-get -y install libxml2-dev libxslt1-dev
~~~

### 2. rbenv & ruby & bundler

~~~
curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
rbenv bootstrap-ubuntu-12-04
rbenv install 1.9.3-p125
rbenv global 1.9.3-p125
gem install bundler --no-ri --no-rdoc
rbenv rehash
~~~

### 3. nginx

~~~
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:nginx/stable
sudo apt-get update
sudo apt-get -y install nginx
sudo ln -s /home/peter/happycasts/config/nginx.conf /etc/nginx/sites-enabled/happycasts
sudo rm /etc/nginx/sites-enabled/default
sudo service nginx start
~~~

~~~
upstream unicorn {
  server unix:/tmp/unicorn.happycasts.sock fail_timeout=0;
}

server {
  listen 80 default deferred;
  # server_name example.com;
  root /home/peter/happycasts/public;

  location ^~ /assets/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  try_files $uri/index.html $uri @unicorn;
  location @unicorn {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://unicorn;
  }

  error_page 500 502 503 504 /500.html;
  client_max_body_size 4G;
  keepalive_timeout 10;
}
~~~
### 4. unicorn

~~~
kill -9 `cat tmp/pids/unicorn.pid`
unicorn -D -c config/unicorn.rb -E production
ps aux|grep unicorn
mkdir -p tmp/pids
touch  tmp/pids/unicorn.pid
mkdir log/
touch log/unicorn.log
~~~

~~~
root = "/home/deployer/happycasts/"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.happycasts.sock"
worker_processes 2
timeout 30
~~~