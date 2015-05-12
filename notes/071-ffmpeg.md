---
layout: shownote
title: Ffmpeg
---
- <http://www.ffmpeg.org/>
- <http://askubuntu.com/questions/148554/installingffmpeg-libx264-and-libavfilter>

安装依赖

~~~
sudo apt-get update
sudo apt-get -y install build-essential checkinstall git libfaac-dev libgpac-dev \
libjack-jackd2-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev \
libsdl1.2-dev libtheora-dev libva-dev libvdpau-dev libvorbis-dev libx11-dev \
libxfixes-dev texi2html yasm zlib1g-dev
~~~

安装 x264

~~~
cd
git clone git://git.videolan.org/x264
cd x264
./configure --enable-shared  --disable-asm
make
sudo checkinstall --pkgname=x264 --pkgversion="3:$(./version.sh | \
  awk -F'[" ]' '/POINT/{print $4"+git"$5}')" --backup=no --deldoc=yes \
  --fstrans=no --default
~~~

安装 ffmpeg

~~~
cd
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
./configure --enable-gpl --enable-libfaac --enable-libmp3lame
--enable-libopencore-amrnb \
 --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis \
 --enable-libx264 --enable-nonfree --enable-version3 --enable-x11grab
make
sudo checkinstall --pkgname=ffmpeg --pkgversion="5:$(date +%Y%m%d%H%M)-git" --backup=no \
--deldoc=yes --fstrans=no --default
~~~

