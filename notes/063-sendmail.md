- <http://railscasts.com/episodes/61-sending-email-revised>

~~~
sudo su
cd /etc/mail
echo "MASQUERADE_AS(`haoqicat.com')dnl`)" >sendmail.mc
m4 sendmail.mc >sendmail.cf
/etc/init.d/sendmail restart
~~~

~~~
sendmail happypeter1983@gmail.com
Subject: Test Sendmail
From: Peter Wang <peter@haoqicat.com>
.
~~~