- <http://thenewboston.org/list.php?cat=49>

### 1. 查看我们指定的信息

~~~
SELECT *
FROM users
LIMIT 2 , 4

SLECT id, name
FROM users

SELECT *
FROM users
WHERE id=3

SELECT *
FROM users
WHERE id<3

SELECT *
FROM users
WHERE id BETWEEN 20 and 30

SELECT *
FROM users
WHERE id>20 and id<30
~~~

使用 `DISTINCT` 过滤重复输出
~~~
SELECT DISTINCT state
FROM customers
~~~
### 2. 修改数据库的结构

新建一张表
~~~
CREATE TABLE users(
id int NOT NULL AUTO_INCREMENT,
username varchar(30) NOT NULL,
PRIMARY KEY(id)
);
~~~

修改表
~~~
ALTER TABLE users ADD email varchar(20)
ALTER TABLE users DROP email
DROP TABLE users
RENAME TABLE users TO superusers
~~~

查找名字以 `h` 或 `H` 打头的用户信息
~~~
SELECT * FROM users WHERE name LIKE 'h%'
~~~

### 3. 修改数据

~~~
INSERT INTO users (name, email) VALUES ('peter', 'peter@peter.com')
UPDATE users SET name='happypeter' WHERE id=1;
~~~

删除某个用户的信息
~~~
DELETE FROM users WHERE id=12
~~~

### 4. 导入导出

~~~
mysqldump -uroot -p111111 forum>forum.sql
mysql -uroot -p111111 forum<forum.sql
~~~