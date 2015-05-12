---
layout: shownote
title: Redirection
---
__Resources:__

- [The Linux Command Line](http://linuxcommand.org/tlcl.php)


~~~
cat file1 file2 >file3
~~~

~~~
cat file1 >file4
cat file2 >>file4
~~~

~~~
>file4
>file5
ls >output.txt 2>&1
ls &>output.txt
~~~

~~~
#!/usr/bin/env bash
>output.txt
for dir in /bin/usr /usr/bin
do
    ls $dir &>output.txt
done
~~~

~~~
ls /bin|grep ed
~~~

