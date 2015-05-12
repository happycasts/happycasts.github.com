__Resources:__

- [help](http://help.github.com/)
- [github](http://github.com) 
- [ssh issues](http://help.github.com/ssh-issues/) 
  
~~~
git config --global user.name "Your Name"
git config --global user.email happypeter1983@gmail.com
~~~

~~~
mkdir first-proj
cd first-proj
git init
touch README
git add README
git commit -m 'first commit' 
git remote add origin git@github.com:lovelypeter/first-proj.git
git push -u origin master
~~~

~~~
cat ~/.gitconfig
~~~

~~~
mv .ssh ssh.bak
ssh-keygen 
~~~