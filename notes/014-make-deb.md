__Resources:__

- <http://users.telenet.be/mydotcom/howto/linux/package.htm>
- <http://www.bytehold.com/index.php/projects/176-debian-binary-package-and-repository-howto>
- <http://www.debian.org/doc/debian-policy/ch-controlfields.html>
- [Ubuntu wiki--complete](https://wiki.ubuntu.com/PackagingGuide/Complete)
- [Ubuntu wiki--basic](https://wiki.ubuntu.com/PackagingGuide/Basic?action=show)

~~~
gcc hello.c -o happyhello
~~~

~~~
cd xxx
mkdir debian
cd debian
mkdir DEBIAN
vim control
~~~

~~~
Package: happyhello
Version: 1.0
Architecture: i386
Maintainer: Peter Wang <happypeter1983@gmail.com>
Installed-Size: 8
Depends: hello
Homepage: http://www.haoduoshipin.com
Description: happypeter's helloWorld
  the best software ever made!
  Everything is cool
~~~

~~~
dpkg-deb --build  debian/
sudo apt-get install dpkg-dev
dpkg-name debian.deb
sudo dpkg -i happyhello_1.0_i386.deb
sudo apt-get install hello
~~~

~~~
sudo apt-get remove happyhello
~~~

~~~
#!/bin/bash
echo "hi I am postinst"
~~~

~~~
#!/bin/bash
echo "hi I am prerm"
~~~

~~~
/etc/happyhello/happyconf
~~~

~~~
dpkg -L happyhello
sudo apt-get purge happyhello
ls /etc/|grep happy
sudo apt-get remove happyhello
~~~