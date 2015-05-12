---
layout: shownote
title: Ack grep
---
__Resources:__

- [Ack](http://betterthangrep.com/) 

~~~
sudo aptitude install ack-grep
sudo ln -s `which ack-grep` /bin/ack
ack --help-types|less
~~~

~~~
ack hello
ack -a hello
ack --js hello
ack --nojs hello 
~~~

~~~
:Ack -a hello
:Ack -Q "*h"
~~~

