--1、登录MySQL
mysql -uroot -pmysqladmin

--2、创建数据库
DROP DATABASE mldn ;
CREATE DATABASE mldn CHARACTER SET UTF8 ;

--3、创建表
DROP TABLE IF EXISTS member;
CREATE TABLE member (
	mid      INT    AUTO_INCREMENT,
	age      INT    NOT NULL,
	brithday DATETIME,
	name     VARCHAR(50) NOT NULL,
	note     TEXT,
	CONSTRAINT pk_mid PRIMARY KEY(mid)
) type=innodb;

--4、查看表结构
DESC member;

--5、增加一行
INSERT INTO member(age,brithday,name,note) VALUES(20,'1996-10-10 11:11:11','aa','aaa');

--6、取得自动增长的值
SELECT LAST_INSERT_ID();

--7、分页处理
SELECT * FROM member LIMIT 5,5;
