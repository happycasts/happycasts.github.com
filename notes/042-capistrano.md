重要纠错: 视频中为了让 `#{try_sudo}`生效，所以 `set :use_sudo, true`。这样是不科学的，因为下次我们去执行 `cap deploy:setup` 时所有的目录创建等操作将会默认由 root 用户去执行，这在后续的操作中可能会引起很多 `Permission denied!`。

解决方案: `set :use_sudo, true` 中 true 改为 false，以后用到 `#{try_sudo}` 的地方，用 `#{sudo}` 就可以了。

- <https://github.com/capistrano/capistrano/wiki>
- [The Pdf chart](https://github.com/capistrano/capistrano/wiki/2.x-Default-Deployment-Behaviour)

### 1. deploy.rb

check this [gist](https://gist.github.com/3977544)

### 2. unicorn_init.sh

check this [gist](https://gist.github.com/3977557)

### 3. For more info, check Ep38

- <http://haoduoshipin.com/episodes/38>