---
layout: shownote
title: Resque
---
- [code on Github](https://github.com/happycasts/episode-89-demo)
- <https://github.com/resque/resque>
- <https://github.com/zapnap/resque_mailer>
- <https://github.com/resque/resque-web>
- <http://railscasts.com/episodes/271-resque>

### 勘误

视频三分十秒初我说 `make; make install` 应该是 `make;sudo make install` 

### 安装 redis

~~~
git clone git@github.com:antirez/redis.git
cd redis
make; make install #应该是 sudo make install 
cd utils
sudo ./install_server.sh
sudo service redis_6379 start|stop
sudo update-rc.d redis_6379 defaults
~~~

### 代码中添加 resque

~~~
gem 'resque', :require => "resque/server"
~~~

~~~
require "resque/tasks"
task "resque:setup" => :environment
~~~

~~~
class DurationGetter
  @queue = :video_info
  def self.perform(episode_id)
    episode = Episode.find(episode_id)
    sleep 10
    result = `avconv -i #{episode.asset_url} 2>&1`
    if result =~ /Duration: ([\d][\d]:[\d][\d]:[\d][\d].[\d]+)/
      episode.update_attributes(duration: $1.to_s)
    end
  end
end
~~~

~~~
def create
...
  Resque.enqueue(DurationGetter, @episode.id)
...
~~~

~~~
#!/usr/bin/env bash
kill -9 `cat tmp/pids/resque.pid`
rake resque:work QUEUE='*' PIDFILE='tmp/pids/resque.pid' BACKGROUND=yes
~~~


### 添加 resque-web

~~~
gem 'resque-web', require: 'resque_web'
~~~

~~~
require "resque_web"
ResqueDemo::Application.routes.draw do
...
ResqueWeb::Engine.eager_load!
mount ResqueWeb::Engine => "/resque_web"
~~~

