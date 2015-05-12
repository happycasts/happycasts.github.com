__Resources:__

- [github pages](http://pages.github.com/)
- [Tom's blog](http://tom.preston-werner.com/2008/11/17/blogging-like-a-hacker.html)
- [markdown](http://daringfireball.net/projects/markdown/)

```console
mkdir lovelypeter.github.com
cd lovelypeter.github.com
git init
touch README
git add README
git remote add origin git@github.com:lovelypeter/loverlypeter.github.com.git
echo "hi I am index.html">index.html
git add .
git ci
git push -u origin master
...
```

_config.yml 中写

```yaml
markdown: maruku
# 2014-06-08 UPDATE: maruku 已经作废了，现在可以用 kramdown
pygments: true
```