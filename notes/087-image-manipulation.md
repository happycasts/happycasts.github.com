---
layout: shownote
title: Image manipulation
---

### 安装工具

- <http://www.imagemagick.org/script/index.php>
- <http://railscasts.com/episodes/374-image-manipulation>

~~~
sudo apt-get install gimp graphicsmagick-libmagick-dev-compat libmagickwand-dev
~~~

### 变黑白


~~~
convert  cat.jpg  -quantize GRAY -colors 256  grey.jpg
# Gimp -> Colors -> Desaturate
~~~

### 缩放图片

~~~
convert input.jpg -resize 50% output.jpg
# Gimp -> Image -> Scale Image
~~~

### 剪裁局部图片

~~~
convert input.jpg -resize '150x150' -gravity center -crop '100x100+0-4' output.jpg
# Gimp -> Ctrl-A -> Ctrl-X -> Ctrl-N -> Ctrl-V -> Layer -> Scale Layer
~~~

