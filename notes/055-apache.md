---
layout: shownote
title: Apache
---
- <http://httpd.apache.org/>


### 1. 配置文件样例

~~~
<VirtualHost *:80>
   ServerName peter.com
   DocumentRoot /home/peter/sites/peter
</VirtualHost>
<VirtualHost *:80>
   ServerName billie.com
   DocumentRoot /home/peter/sites/billie
</VirtualHost>
~~~

