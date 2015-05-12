---
layout: shownote
title: Strong parameter
---
- strong parameter :
  <https://github.com/rails/strong_parameters>

- burp:
  <http://portswigger.net/burp/>
  <http://portswigger.net/burp/help/suite_gettingstarted.html>


- github安全漏洞: <https://github.com/blog/1068-public-key-security-vulnerability-and-mitigation>

### 什么是 mass assignment:

如果有 mass assignment 我们可以

~~~ ruby
attrs = {:first => "John", :last => "Doe", :email => "john.doe@example.com"}
user = User.new(attrs)
~~~

如果没有 mass assignment

~~~ ruby
attrs = {:first => "John", :last => "Doe", :email => "john.doe@example.com"}
user = User.new
user.first = attrs[:first]
user.last  = attrs[:last]
user.email = attrs[:email]
~~~

### command启动burp:

~~~
java -jar -Xmx1024m /path/to/burp.jar
~~~

### 配置burp
preference -> advanced setting -> proxy
127.0.0.1 8080 


~~~ ruby
 private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first, :last)
    end
~~~

