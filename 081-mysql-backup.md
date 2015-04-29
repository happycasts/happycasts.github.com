---
layout: shownote
title: Mysql backup
---
~~~
ssh peter@haoduoshipin.com ‘ cd happycasts_production; \
                           mysqldump --extended-insert=FALSE --complete-insert=TRUE -uroot -pMYPASSWORD happycasts_production>happycasts_production.sql; \
                           git commit -a -m"i";\
                           git push
’

cd happycasts_production; git pull
~~~

