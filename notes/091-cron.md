- <http://en.wikipedia.org/wiki/Cron>
- <http://railscasts.com/episodes/164-cron-in-ruby>

- 编辑 crontab

~~~
crontab -e
~~~

每小时执行一个脚本，可以用如下的语句

~~~
0 0 * * *  /home/peter/bin/db_backup.sh
~~~

- 查看 cron 的任务

~~~
crontab -l
~~~