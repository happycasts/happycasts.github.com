~~~
sudo apt-get install git
~~~

~~~
git init 
ls -a
git status
~~~

~~~
git add README
git commit -m "1st"
~~~

~~~
git config --global user.name "Peter Wang"
git config --global user.email "happypeter1983@gmail.com"
git log
git log -p
~~~

~~~
sudo apt-get install tig
~~~

~~~
git commit -a
git diff
~~~

~~~
git config --global core.editor vim
git commit -a -v 
git config --global alias.ci "commit -a -v"
~~~

~~~
[user]
    name = Peter Wang
    email = happypeter1983@gmail.com
[core]
    editor = vim
[alias]
    ci = commit -a -v
~~~