---
layout: shownote
title: Grep
---
__Resources:__

- <http://en.wikipedia.org/wiki/Grep>
- [happygrep](http://happypeter.github.com/happygrep/)


~~~
:e happy.txt
:g/^log/p
~~~

~~~
grep ^log happy.txt
echo "log"|grep log
~~~

~~~
cat log.txt
grep log log.txt
grep -i log log.txt
grep -w log log.txt
grep '\<log' log.txt
grep 'log\>' log.txt
grep 'log\>' log.txt|grep -v sys
~~~

~~~
grep awk `find .`
find . -exec grep awk {} +
echo "awk hello">newfile
grep awk `find . -mmin -3`
~~~

~~~
ps aux|grep cron|grep -v grep|awk '{print $2}'
perl -pi -e 's/log/hello/g' log.txt
sed -i 's/hello/log/g' log.txt
~~~

~~~
tail -f log/development.log|grep --context=3 SELECT
~~~

