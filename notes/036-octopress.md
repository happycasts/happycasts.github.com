- <http://octopress.org/docs/>
- <https://github.com/happycasts/happycasts.github.com>
- Update: 2014-6-9 上面的这个 repo 我又改用 jekyll，octopress 感觉还是麻烦

### 1. 安装配置

~~~
sudo apt-get update; sudo apt-get install git
curl -L https://get.rvm.io | bash -s stable --ruby
gem install bundler
bundle install
~~~
### 2. 使用

安装 theme

~~~
rake install
~~~

新建博客和页面

~~~
rake new_post["hello"]
rake new_page["about.markdown"]
~~~

一个工作循环:

编辑 -> 预览 -> rake gen_deploy -> 把 source 分支的修改 push 到 github

### 3. 更改网站样式相关

- <https://github.com/imathis/octopress/wiki/List-Of-Octopress-Themes>
- <https://github.com/imathis/octopress/wiki/Octopress-Sites>