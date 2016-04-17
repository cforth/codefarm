/*
** DML&DDL综合实战
** 自己建立数据表(约束)、并且实现数据的增加、查询、修改、删除
**
** 现有一个商店的数据库，记录顾客及其购物的情况，由下面三个表组成：
** ① 商品 product(商品号 productid, 商品名 productname, 单价 unitprice, 商品类别category, 供应商provider) ;
** ② 顾客 customer(顾客号 customerid, 姓名 name, 住址 location) ;
** ③ 购买 purcase(顾客号 customerid, 商品号 productid, 购买数量quantity) ; 
** 每个顾客可以购买多个商品，每件商品可以被多个顾客购买。
*/

/*
** 一、建表，在定义中要求声明如下约束：
** （1）、每个表的主外键；
** （2）、顾客的姓名和商品名不能为空值；
** （3）、单价必须大于0，购买数量必须在0到20之间；
*/
--删除数据表
DROP TABLE purcase PURGE ;
DROP TABLE customer PURGE ;
DROP TABLE product PURGE ;
--创建表
--1、创建顾客表
CREATE TABLE customer (
    customerid      VARCHAR2(3) ,
    name            VARCHAR2(20) NOT NULL ,
    location        VARCHAR2(50) ,
    CONSTRAINT      pk_customerid PRIMARY KEY(customerid)
);
--2、创建商品表
CREATE TABLE product (
    productid       VARCHAR2(3),
    productname     VARCHAR2(20) NOT NULL ,
    unitprice       NUMBER,
    category        VARCHAR2(20) ,
    provider        VARCHAR2(20) ,
    CONSTRAINT  pk_productid PRIMARY KEY(productid) ,
    CONSTRAINT  unitprice CHECK (unitprice > 0)
);
--3、创建购买记录表
CREATE TABLE purcase (
    customerid      VARCHAR2(3) ,
    productid       VARCHAR2(3) ,
    quantity        NUMBER,
    CONSTRAINT  fk_customerid FOREIGN KEY(customerid) REFERENCES customer(customerid) ON DELETE CASCADE ,
    CONSTRAINT  fk_productid FOREIGN KEY(productid) REFERENCES product(productid) ON DELETE CASCADE ,
    CONSTRAINT  ck_quantity CHECK(quantity BETWEEN 0 AND 20)
);

/*
** 二、往表中插入数据
*/
--测试数据
--1、增加商品数据
INSERT INTO product(productid,productname,unitprice,category,provider) VALUES('M01','佳洁士',8.0,'牙膏','宝洁');
INSERT INTO product(productid,productname,unitprice,category,provider) VALUES('M02','高露洁',6.5,'牙膏','高露洁');
INSERT INTO product(productid,productname,unitprice,category,provider) VALUES('M03','洁诺',5.0,'牙膏','联合利华');
INSERT INTO product(productid,productname,unitprice,category,provider) VALUES('M04','舒肤佳',3.0,'香皂','宝洁');
INSERT INTO product(productid,productname,unitprice,category,provider) VALUES('M05','夏士莲',5.0,'香皂','联合利华');
INSERT INTO product(productid,productname,unitprice,category,provider) VALUES('M06','雕牌',2.5,'洗衣粉','纳爱斯');
INSERT INTO product(productid,productname,unitprice,category,provider) VALUES('M07','中华',3.5,'牙膏','联合利华');
INSERT INTO product(productid,productname,unitprice,category,provider) VALUES('M08','汰渍',3.0,'洗衣粉','宝洁');
INSERT INTO product(productid,productname,unitprice,category,provider) VALUES('M09','碧浪',4.0,'洗衣粉','宝洁');

--2、增加顾客数据
INSERT INTO customer(customerid,name,location) VALUES('C01','Dennis','海淀');
INSERT INTO customer(customerid,name,location) VALUES('C02','John','朝阳');
INSERT INTO customer(customerid,name,location) VALUES('C03','Tom','东城');
INSERT INTO customer(customerid,name,location) VALUES('C04','Jenny','东城');
INSERT INTO customer(customerid,name,location) VALUES('C05','Rick','西城');

--3、增加购买记录信息
INSERT INTO purcase(customerid,productid,quantity) VALUES('C01','M01',3);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C01','M05',2);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C01','M08',2);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C02','M02',5);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C02','M06',4);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C03','M01',1);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C03','M05',1);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C03','M06',3);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C03','M08',1);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C04','M03',7);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C04','M04',3);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C05','M06',2);
INSERT INTO purcase(customerid,productid,quantity) VALUES('C05','M07',8);

--事务提交
COMMIT;

/*
** 三、用SQL语句完成下列查询
*/
--1、求购买了供应商“宝洁”产品的所有顾客；
SELECT * 
FROM customer
WHERE customerid IN ( 
    SELECT DISTINCT customerid 
    FROM purcase 
    WHERE productid IN (
        SELECT productid 
        FROM product 
        WHERE provider = '宝洁')) ;
        
--2、求购买的商品包含了顾客“Dennis”所购买的所有商品的顾客（姓名）；
/*如果想实现这个需求，只能使用EXISTS()
SELECT * FROM customer ca
WHERE [NOT] EXISTS(
      是否可以匹配的查询);
*/
SELECT * FROM customer ca
WHERE NOT EXISTS((
    SELECT DISTINCT productid
    FROM purcase p1
    WHERE p1.customerid = (SELECT customerid FROM customer WHERE name = 'Dennis')) 
    MINUS(
    SELECT p2.productid
    FROM purcase p2
    WHERE p2.customerid = ca.customerid)
) AND ca.name <> 'Dennis';

--3、求牙膏卖出数量最多的供应商
SELECT pro1.provider, SUM(p1.quantity) sum
FROM purcase p1, product pro1
WHERE p1.productid = pro1.productid
    AND pro1.category = '牙膏'
GROUP BY pro1.provider
HAVING SUM(p1.quantity) = (
    SELECT MAX(SUM(p1.quantity))
    FROM purcase p1, product pro1
    WHERE p1.productid = pro1.productid
        AND pro1.category = '牙膏'
    GROUP BY pro1.provider);
    
--4、将所有的牙膏商品单价增加10%；
UPDATE product SET unitprice = unitprice*1.1 WHERE category = '牙膏';

--5、删除从未被购买的商品记录。
DELETE FROM product WHERE productid NOT IN (
    SELECT productid FROM purcase) ;
