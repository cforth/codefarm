--1,设置命令
SET LINESIZE 300;
SET PAGESIZE 30;

--2,切换用户
CONN system/manager
CONN sys/change_on_install AS SYSDBA

--3,调用本机命令
HOST echo helloworld

--4,查看所有表
SELECT * FROM tab;

--5，查看单张表结构
DESC 表名称;

--6,调整列宽度
COL 列表 FOR A10 

--7,简单查询
--② SELECT [DISTINCT] * | 列名称[别名], 列名称[别名],...
--① FROM 表名称 [别名]

SELECT empno,ename,job,sal FROM emp;

--消除重复行,如果查询数据是多个列，只有多个列的行都重复才能消除
SELECT DISTINCT job FROM emp;

--8,查询的结果进行四则运算(基本年薪是月薪乘12)
SELECT empno,ename,sal*12 FROM emp;

--别名定义,不建议使用中文
SELECT empno,ename,sal*12 income FROM emp;

--要求显示每个雇员的编号、姓名、基本年薪（每年可以领取15个月的工资,每月有200元的饭贴、100元的汽车补贴、100元的电话补贴，每年有5个月的高温补贴200元）
SELECT empno, ename, 
	(sal*15 + (200 + 100 + 100)*12 + 200 * 5) income FROM emp;

--设置一些常量,这些常量可以直接进行输出
--直接查询常量：
SELECT '雇员', empno, ename FROM emp ;

--连接两个列
SELECT empno || ename FROM emp ;

--转换显示格式,字符串需要单引号，别名不需要
SELECT '雇员编号:'|| empno || ',姓名:' || ename || ',收入：' || sal info FROM emp;

--9,限定查询
--【③控制要显示的数据列】 SELECT [DISTINCT] * | 列名称[别名], 列名称[别名],...
--【①确定数据来源】 FROM 表名称 [别名]
--【②确定满足条件的数据行】 [WHERE 过滤条件(s)] 

SELECT *
FROM emp
WHERE sal>1500 ;

--在Oracle中所有数据区分大小写
SELECT *
FROM emp
WHERE ename='SMITH';

SELECT empno,ename,job
FROM emp
WHERE job!='SALESMAN' ;

--逻辑运算符
SELECT empno,ename,sal
FROM emp
WHERE sal>=1500 AND sal<=3000 ;

SELECT *
FROM emp
WHERE sal>2000 OR job='CLERK';

SELECT *
FROM emp
WHERE NOT sal>2000 ;

--10,范围查询
BETWEEN 最小值（数字、日期） AND 最大值

SELECT *
FROM emp
WHERE sal BETWEEN 1500 AND 2000 ;

--日期用字符串表示
SELECT *
FROM emp
WHERE hiredate BETWEEN '01-1月-1981' AND '31-12月-81' ;

--空判断
SELECT *
FROM emp
WHERE comm IS NOT NULL ;

--IN操作符(小范围选定)
SELECT *
FROM emp
WHERE empno IN (7369, 7788, 9999) ;

SELECT *
FROM emp
WHERE empno NOT IN (7369, 7788, 9999) ;

--模糊查询LIKE('_'匹配一个字符，'%'匹配零位、一位或多位字符
SELECT *
FROM emp
WHERE ename LIKE 'A%' ;

SELECT *
FROM emp
WHERE ename LIKE '%A%' ;

--11，查询排序
--【③控制要显示的数据列】SELECT [DISTINCT] * | 列名称[别名], 列名称[别名],...
--【①确定数据来源】FROM 表名称 [别名]
--【②确定满足条件的数据行】[WHERE 过滤条件(s)] 
--【④针对查询结果进行排序】[ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],...];

--ASC是升序排序
SELECT *
FROM emp
ORDER BY sal ASC ;

--DESC是降序排序
SELECT *
FROM emp
WHERE job='SALESMAN'
ORDER BY hiredate DESC ;

SELECT *
FROM emp
ORDER BY sal DESC, hiredate ASC ;

--ORDER BY 能调用SELECT子句里定义的别名，其他的基本都不可以
SELECT empno, ename, sal*12 income
FROM emp
ORDER BY income ;

--12，简单查询练习
--选择部门30中的所有员工
SELECT * FROM emp WHERE deptno=30 ;

--列出所有办事员的姓名，编号和部门编号
SELECT ename, empno, deptno FROM emp WHERE job='CLERK' ;

--找出佣金高于薪金的60%的员工
SELECT * FROM emp WHERE comm >= sal*0.6 ;

--找出部门10中所有经理（MANAGER）和部门20中所有的办事员（CLERK）
SELECT * 
FROM emp 
WHERE (deptno = 10 AND job = 'MANAGER') OR (deptno = 20 AND job = 'CLERK') ;

--找出部门10中所有经理（MANAGER）,部门20中所有的办事员（CLERK）,既不是经理又不是办事员但是薪金大于等于2000的所有员工的详细资料
SELECT * 
FROM emp 
WHERE (deptno = 10 AND job = 'MANAGER') OR (deptno = 20 AND job = 'CLERK') OR (job NOT IN ('MANAGER', 'CLERK') AND sal > 2000) ;

--找出收取佣金的员工的不同工作
SELECT DISTINCT job
FROM emp
WHERE comm IS NOT NULL ;

--找出不收取佣金或收取的佣金低于100的员工
SELECT *
FROM emp
WHERE (comm IS NULL) OR (comm < 100) ;

--显示不带有“R"的员工的姓名
SELECT *
FROM emp 
WHERE ename NOT LIKE '%R%' ;

--显示姓名字段的任何位置包含“A”的所有员工的姓名，显示的结果按照基本工资由高到低排序，如果基本工资相同，则按照雇佣年限由早到晚排序，如果雇用日期相同，则按照职位排序
SELECT *
FROM emp
WHERE ename NOT LIKE '%A%'
ORDER BY sal DESC, hiredate ASC, job;
