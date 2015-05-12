__Resources:__

- <http://www.jejik.com/articles/2006/09/setting_up_and_managing_an_apt_repository_with_reprepro/>
- <http://cn.archive.ubuntu.com/ubuntu/>
- <http://media.haoduoshipin.com/apt/>
- <http://tech.randomness.org.uk/Setting_up_a_Signed_apt_repo.html>
- <http://apt.baruwa.org/>
- <https://help.launchpad.net/Packaging/PPA>

~~~
sudo vim /etc/apt/sources.list
~~~

~~~
Package: happyhello
Maintainer: Peter Wang <happypeter1983@gmail.com>
Architecture: i386
Version: 1.0
Depends: hello
Filename: pool/main/h/happyhello/happyhello_1.0_i386.deb
Size: 2960
MD5sum: f093639d521159e82c652677e73a4173
SHA1: 5816634c05f28993afcab1fa007a99b3dd5117cb
SHA256: 976a41623a1774b559a430c8145c2bf9b57fdf4581523b732c286e631d6e75fa
~~~

~~~
du -b happyhello_1.0_i386.deb
md5sum happyhello_1.0_i386.deb
sha1sum happyhello_1.0_i386.deb
sha256sum happyhello_1.0_i386.deb
~~~

~~~
scp -r * media.haoduoshipin.com:media/apt/
~~~

~~~
# peter add his own repo
deb http://media.haoduoshipin.com/apt/ natty main
~~~

~~~
sudo apt-get update
cd /var/lib/apt/lists/
vim media.haoduoshipin.com_apt_dists_natty_main_binary-i386_Packages
cd /var/cache/apt/ # we see pkgcache.bin here
~~~