- [billie66 code](https://github.com/happypeter/happycasts/pull/118/files)
- [railscasts sunspot](http://railscasts.com/episodes?utf8=%E2%9C%93&search=sunspot)
- [my google custom search code](https://github.com/happypeter/happycasts/commit/9b1ca72a)

~~~
bundle
sudo apt-get install -y openjdk-6-jdk # install java stuff
bundle exec  rake sunspot:solr:start# 如果发现有了 db connect refused 错误，就 stop 后再 start 一下
bundle exec rake sunspot:reindex
~~~