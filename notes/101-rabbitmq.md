本期视频依旧是由最英俊的李宗晟同学为大家奉献，大家有问题可以在这里留言，或者发邮件到 lizongshenglzs@gmail.com 和他讨论。

- download: <http://www.rabbitmq.com/download.html>
- tutorial: <http://www.rabbitmq.com/tutorials/tutorial-one-ruby.html>

~~~
$rabbitmq-server 启动
~~~

在服务器上的话可以在 detached mode执行
控制命令

~~~
$rabbitmqctl status 查看状态
$rabbitmqctl stop 停止server
~~~

~~~
gem 'bunny'
~~~

~~~
$bundle install
~~~

~~~
require 'bunny'
def show
   conn = Bunny.new
   conn.start
   ch   = conn.create_channel
   q    = ch.queue("hello")
   ch.default_exchange.publish("House.do_something", :routing_key => q.name)
   puts " [x] Sent 'Hello World!'"
end
~~~

~~~
require "bunny"
class House < ActiveRecord::Base
  def self.do_something
    sleep 5
    puts 'oh yeah!!!!!!'
  end

  def self.get_work_and_do_work
    conn = Bunny.new
    conn.start

    ch   = conn.create_channel
    q    = ch.queue("hello")
    puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
    q.subscribe(:block => true) do |delivery_info, properties, body|
      puts " [x] Received #{body}"
      class_name = body.split('.')[0]
      method_name = body.split('.')[1]
      #Module.const_get()
      #eval()
      class_name.constantize.send(method_name.to_sym)
    end
  end
end
~~~