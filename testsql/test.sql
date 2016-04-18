--1,设置命令
SET LINESIZE 300;
SET PAGESIZE 30;

--2,切换用户
CONN system/manager
CONN sys/change_on_install AS SYSDBA
CONN scott/tiger

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

--13，单行函数
--返回值 函数名称(参数)

--字符串函数(dual为虚拟表)
--字符串 UPPER(列|字符串)  转为大写字母
SELECT UPPER('hello') FROM dual ;

--输入变量的方法('SCOTT')
SELECT * FROM emp WHERE ename = UPPER('&inputname') ;

--字符串 L0WER(列|字符串)
SELECT LOWER(ename) FROM emp ;

--字符串 INITCAP(列|字符串)
SELECT ename, INITCAP(ename) FROM emp ;

--字符串 LENGTH(列|字符串)
SELECT * FROM emp WHERE LENGTH(ename) = 5 ;

--字符串 SUBSTR(列|字符串, 开始索引, [长度]) 字符串截取
SELECT SUBSTR('helloworld', 6) FROM dual ;
SELECT SUBSTR('helloworld', 1, 5) FROM dual ;
SELECT ename, SUBSTR(ename, 1, 3) FROM emp ;
SELECT ename, SUBSTR(ename, LENGTH(ename)-2) FROM emp ;
SELECT ename, SUBSTR(ename, -3) FROM emp ;

--数值函数
--数字 ROUND(列|数字 [, 小数位]) 会四舍五入
SELECT ROUND(789.5671234) FROM dual ;
SELECT ROUND(789.5671234, 2) FROM dual ;
SELECT ROUND(789.5671234, -2) FROM dual ;

--数字 TRUNC(列|数字 [, 小数位])  不会进位
SELECT TRUNC(789.5671234),
        TRUNC(789.5671234, 2),
        TRUNC(789.5671234, 3)
 FROM dual ;

--数字 MOD(列|数字， 列|数字)
SELECT MOD(10, 3) FROM dual ;

--日期时间函数
--伪列SYSDATE, SYSTIMESTAMP
SELECT SYSDATE FROM dual ;
SELECT SYSTIMESTAMP FROM dual ;

--进一步观察伪列
SELECT ename, job, sal, SYSDATE FROM emp ;

--日期加减
SELECT SYSDATE-7, SYSDATE+280 FROM dual ;
SELECT empno, ename, job, SYSDATE-hiredate FROM emp ;

--准确的日期操作
--日期 ADD_MONTHS(列|日期, 月数)
SELECT ADD_MONTHS(SYSDATE, 4) FROM dual ;

--日期 MONTHS_BETWEEN(列|日期, 列|日期)
SELECT empno, ename, hiredate, MONTHS_BETWEEN(SYSDATE, hiredate) FROM emp ;

--日期 LAST_DAY(列|日期)
SELECT LAST_DAY(SYSDATE) FROM dual ;

SELECT empno, ename, hiredate, LAST_DAY(hiredate) - 2 
FROM emp 
WHERE hiredate = LAST_DAY(hiredate) - 2;

--日期 NEXT_DAY(列|日期, 星期X)
SELECT NEXT_DAY(SYSDATE, '星期五') FROM dual ;

--要求以年、月、日的方式计算出每个雇员到现在为止雇佣年限
SELECT empno, ename, hiredate,
        TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)/12) year,
        TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, hiredate), 12)) months,
        TRUNC(SYSDATE - ADD_MONTHS(hiredate, MONTHS_BETWEEN(SYSDATE, hiredate))) days
FROM emp ;

--转换函数
--字符串 TO_CHAR(列|日期|数字, 转换格式)
SELECT TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss') FROM dual ;

--日期拆分
SELECT TO_CHAR(SYSDATE, 'yyyy'), TO_CHAR(SYSDATE, 'mm'), TO_CHAR(SYSDATE, 'dd') FROM dual ;
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'mm') = '02' ;
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'mm') = 2 ;

--数字拆分
SELECT TO_CHAR(915645691312, 'L999,999,999,999') FROM dual ;

--日期 TO_DATE(列|字符串, 转换格式)
SELECT TO_DATE('1889-10-18', 'yyyy-mm-dd') FROM dual ;

--数字 TO_NUMBER(列|字符串)
SELECT TO_NUMBER('1') + TO_NUMBER('2') FROM dual ;
SELECT '1' + '2' FROM dual ;

--14，通用函数
--数学 NVL(列|NULL, 默认值)
SELECT empno, ename, sal, comm, (sal + NVL(comm, 0))*12 FROM emp ;

--数据类型 DECODE(列|数值, 比较内容1, 显示内容1, 比较内容2, 显示内容2, ...[, 默认显示内容])
SELECT ename, job, DECODE(job, 'CLERK', '办事员', 'SALESMAN', '销售', 'MANAGER', '经理', '---') FROM emp ;

--15，多表查询(优秀的设计不允许)
--【③控制要显示的数据列】SELECT [DISTINCT] * | 列名称[别名], 列名称[别名],...
--【①确定数据来源】FROM 表名称 [别名], 表名称 [别名]
--【②确定满足条件的数据行】[WHERE 过滤条件(s)] 
--【④针对查询结果进行排序】[ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],...];

--笛卡尔积的问题
SELECT * FROM emp, dept ;

--消除了显示的笛卡尔积，多表查询很慢
SELECT * 
FROM emp e, dept d 
WHERE e.deptno = d.deptno ;

SELECT e.empno, e.ename, e.job, e.sal, d.dname, d.loc 
FROM emp e, dept d 
WHERE e.deptno = d.deptno ;

SELECT e.empno, e.ename, e.job, e.sal, s.grade
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND hisal ;

SELECT e.empno, e.ename, e.job, e.sal, s.grade, d.dname
FROM emp e, salgrade s, dept d
WHERE e.sal BETWEEN s.losal AND s.hisal 
        AND e.deptno = d.deptno ;

--16，表的连接
INSERT INTO emp(empno, ename, job) VALUES(8888, '张三', 'CLERK') ;

--内连接 等值连接(不满足条件的行不显示)
SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno ;

--外连接（左外连接）
SELECT e.empno, e.ename, e.job, e.sal, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno(+) ;

--外连接（右外连接）
SELECT e.empno, e.ename, e.job, e.sal, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno(+) = d.deptno ;

--查询雇员的领导信息
SELECT e.ename, e.job, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+) ;

--17，SQL1999语法实现多表查询，'(+)'标记只有Oralce才有
-- SELECT [DISTINCT] * | 列名称[别名]
-- FROM 表名称1 
--      [CROSS JOIN 表名称2]
--      [NATURAL JOIN 表名称2]
--      [JOIN 表名称 ON(条件)|USING(字段)]
--      [LEFT|RIGHT|FULL OUTER JOIN 表名称2] ;

--CROSS JOIN 交叉连接，产生笛卡尔积
SELECT * FROM emp CROSS JOIN dept ;

--NATURAL JOIN 自然连接，使用关联字段消除笛卡尔积(使用相同的字段)
SELECT * FROM emp NATURAL JOIN dept ;

--JOIN USING 指定关联字段
SELECT * FROM emp JOIN dept USING(deptno) ;

--JOIN ON 如果没有关联字段，可使用ON子句设置条件
SELECT * FROM emp e JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal) ;

--外连接（左外连接）
SELECT * FROM emp LEFT OUTER JOIN dept USING(deptno) ;

--外连接（右外连接）
SELECT * FROM emp RIGHT OUTER JOIN dept USING(deptno) ;

--全外连接
SELECT * FROM emp FULL OUTER JOIN dept USING(deptno) ;

--18，数据集合操作
--【③控制要显示的数据列】SELECT [DISTINCT] * | 列名称[别名], 列名称[别名],...
--【①确定数据来源】FROM 表名称 [别名], 表名称 [别名]
--[【②确定满足条件的数据行】[WHERE 过滤条件(s)] ]
--[【④针对查询结果进行排序】[ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],...] ]
--      UNION|UNION ALL|INSERT|MINUS
--【③控制要显示的数据列】SELECT [DISTINCT] * | 列名称[别名], 列名称[别名],...
--【①确定数据来源】FROM 表名称 [别名], 表名称 [别名]
--[【②确定满足条件的数据行】WHERE 过滤条件(s) ]
--[【④针对查询结果进行排序】ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],... ]
--      UNION|UNION ALL|INSERT|MINUS
--【③控制要显示的数据列】SELECT [DISTINCT] * | 列名称[别名], 列名称[别名],...
--【①确定数据来源】FROM 表名称 [别名], 表名称 [别名]
--[【②确定满足条件的数据行】WHERE 过滤条件(s) ]
--[【④针对查询结果进行排序】ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],... ] ;

--UNION操作 有重复的结果不显示
SELECT empno, ename, job FROM emp WHERE deptno = 10 
        UNION
SELECT empno, ename, job FROM emp ;

--UNION ALL操作 重复的结果全部显示
SELECT empno, ename, job, deptno FROM emp WHERE deptno = 10 
        UNION ALL
SELECT empno, ename, job, deptno FROM emp ;

--INTERSECT操作 取交集
SELECT empno, ename, job, deptno FROM emp WHERE deptno = 10 
        INTERSECT
SELECT empno, ename, job, deptno FROM emp ;

--MINUS操作 差集，由第一个查询减去第二个查询
SELECT empno, ename, job, deptno FROM emp
        MINUS
SELECT empno, ename, job, deptno FROM emp WHERE deptno = 10 ;

--19，分组统计
--基础统计函数
--COUNT(*|[DISTINCT]字段) 不统计为空的数据
SELECT COUNT(*) FROM emp ;
SELECT COUNT(comm) FROM emp ;
SELECT COUNT(DISTINCT job) FROM emp ;


--MAX(字段)
--MIN(字段)
ROLLBACK ;
SELECT MAX(sal), MIN(sal) FROM emp ;
SELECT MAX(hiredate), MIN(hiredate) FROM emp ;

--SUM(数字字段)
--AVG(数字字段)
SELECT SUM(sal), AVG(sal) FROM emp ;
SELECT TRUNC(AVG(MONTHS_BETWEEN(SYSDATE, hiredate)/12)) FROM emp ;

--分组统计操作的实现
--【⑤控制要显示的数据列】SELECT [DISTINCT] 分组字段[别名],... | 统计函数
--【①确定数据来源】FROM 表名称 [别名], 表名称 [别名]
--[【②确定满足条件的数据行】[WHERE 过滤条件(s)] ]
--[【③针对于数据实现分组】GROUP BY 分组字段,分组字段,...]
--[【④针对于分组后的数据进行筛选】HAVING 分组后的过滤条件]
--[【⑥针对查询结果进行排序】ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],...] ;

--要求按照职位分组，统计出每个职位的名称，人数，平均工资
SELECT job, COUNT(empno), AVG(sal)
FROM emp
GROUP BY job ;

--要求查询每个部门编号，以及每个部门的人数、最高与最低工资
SELECT deptno, COUNT(empno), MAX(sal), MIN(sal)
FROM emp
GROUP BY deptno ;

--查询每个部门的名称、人数、平均工资
SELECT d.dname, COUNT(e.empno), AVG(e.sal)
FROM emp e, dept d
WHERE e.deptno(+) = d.deptno
GROUP BY d.dname ;

--查询出每个部门的编号、名称、部门人数、平均服务年限
SELECT d.deptno, d.dname, d.loc, COUNT(e.empno), 
        AVG(MONTHS_BETWEEN(SYSDATE, e.hiredate)/12) year
FROM emp e, dept d
WHERE e.deptno(+) = d.deptno
GROUP BY d.deptno, d.dname, d.loc ;

--利用HAVING实现查询每个职位平均工资大于2000
SELECT job, AVG(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) > 2000 ;

--显示非销售人员工作名称以及从事同一工作雇员的月工资总和，并且要满足从事同一工作雇员的月工资大于5000，输出结果按照月工资的合计升序排序
SELECT job, SUM(sal) sum
FROM emp
WHERE job<>'SALESMAN'
GROUP BY job
HAVING SUM(sal) > 5000
ORDER BY sum ASC ;

--统计公司所有领取佣金与不领取佣金的雇员人数、平均工资
SELECT '领取佣金' title, COUNT(empno), AVG(sal)
FROM emp
WHERE comm IS NOT NULL
    UNION
SELECT '不领取佣金' title, COUNT(empno), AVG(sal)
FROM emp
WHERE comm IS NULL ;

/*20，子查询
SELECT [DISTINCT] 分组字段[别名],... | 统计函数, (
        SELECT [DISTINCT] 分组字段[别名],... | 统计函数
        FROM 表名称 [别名], 表名称 [别名]
        [[WHERE 过滤条件(s)] ]
        [GROUP BY 分组字段,分组字段,...]
        [HAVING 分组后的过滤条件]
        [ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],... ] )
FROM 表名称, (
        SELECT [DISTINCT] 分组字段[别名],... | 统计函数
        FROM 表名称 [别名], 表名称 [别名]
        [[WHERE 过滤条件(s)] ]
        [GROUP BY 分组字段,分组字段,...]
        [HAVING 分组后的过滤条件]
        [ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],... ] )
[[WHERE 过滤条件(s)] (
        SELECT [DISTINCT] 分组字段[别名],... | 统计函数
        FROM 表名称 [别名], 表名称 [别名]
        [[WHERE 过滤条件(s)] ]
        [GROUP BY 分组字段,分组字段,...]
        [HAVING 分组后的过滤条件]
        [ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],...] )]
[GROUP BY 分组字段,分组字段,...]
[HAVING 分组后的过滤条件 (
        SELECT [DISTINCT] 分组字段[别名],... | 统计函数
        FROM 表名称 [别名], 表名称 [别名]
        [[WHERE 过滤条件(s)] ]
        [GROUP BY 分组字段,分组字段,...]
        [HAVING 分组后的过滤条件]
        [ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],...] )]
[ORDER BY 字段 [ASC|DESC], 字段 [ASC|DESC],...] ;
*/

--WHERE子句
--查询出低于公司平均工资的雇员信息
SELECT *
FROM emp
WHERE sal < (
        SELECT AVG(sal) 
        FROM emp) ;

--查询公司最早雇佣的雇员信息
SELECT *
FROM emp        
WHERE hiredate = (
        SELECT MIN(hiredate)
        FROM emp) ;

--与SCOTT从事同一工作，并且工资相同的雇员信息
SELECT *
FROM emp
WHERE (job, sal) = (
        SELECT job, sal 
        FROM emp 
        WHERE ename = 'SCOTT')
    AND ename <> 'SCOTT';
    
--IN操作，指的是与查询返回的内容相同
SELECT * FROM emp 
WHERE sal IN (
        SELECT sal 
        FROM emp 
        WHERE job = 'MANAGER' );

--NOT IN，返回结果里不能包含null
SELECT * FROM emp 
WHERE sal  NOT IN (
        SELECT sal 
        FROM emp 
        WHERE job = 'MANAGER' );
        
--=ANY操作，功能与IN一样
SELECT * FROM emp
WHERE sal = ANY (
        SELECT sal FROM emp WHERE job = 'MANAGER') ;

-->ANY操作，比子查询返回的最小值要大        
SELECT * FROM emp
WHERE sal > ANY (
        SELECT sal FROM emp WHERE job = 'MANAGER') ;

--<ANY操作，比子查询返回的最大值要小        
SELECT * FROM emp
WHERE sal < ANY (
        SELECT sal FROM emp WHERE job = 'MANAGER') ;

-->ALL操作，比子查询返回的最大值要大
SELECT * FROM emp
WHERE sal > ALL (
        SELECT sal FROM emp WHERE job = 'MANAGER') ;

--<ALL操作，比子查询返回的最小值要小
SELECT * FROM emp
WHERE sal < ALL (
        SELECT sal FROM emp WHERE job = 'MANAGER') ;
        
--HAVING子句里面使用子查询
--查询出高于公司平均工资的职位名称、职位人数、平均工资
SELECT job, COUNT(empno), AVG(sal) 
FROM emp
GROUP BY job
HAVING AVG(sal) > (SELECT AVG(sal) FROM emp) ;

--SELECT子句中使用（一般不用）
--查询每个雇员的编号、姓名、职位、部门名称
SELECT e.empno, e.ename, e.job,
        (SELECT d.dname FROM dept d WHERE d.deptno = e.deptno)
FROM emp e ;

--FROM子句中使用子查询
--查询出每个部门的名称、位置、部门人数
SELECT d.dname, d.loc, temp.count
FROM dept d, (SELECT deptno, COUNT(empno) count FROM emp GROUP BY deptno) temp
WHERE d.deptno = temp.deptno(+);

--21，复杂查询练习
--列出薪金高于部门30工作的所有员工的薪金的员工姓名、部门名称、部门人数。
SELECT e.ename, e.sal, d.dname, temp.count
FROM emp e, dept d,
    (SELECT deptno, COUNT(deptno) count FROM emp GROUP BY deptno) temp
WHERE e.deptno = d.deptno 
    AND e.deptno = temp.deptno
    AND e.sal > ALL(SELECT sal FROM emp WHERE deptno=30) ;
    
--列出与“SCOTT”从事相同工作的所有员工及部门名称、部门人数，领导姓名。
SELECT e.ename, d.dname, e.mgr, temp.count, m.ename
FROM emp e, dept d, emp m,
    (SELECT deptno, COUNT(deptno) count FROM emp GROUP BY deptno) temp
WHERE e.job = (SELECT job FROM emp WHERE ename = 'SCOTT')
    AND e.deptno = d.deptno
    AND e.deptno = temp.deptno
    AND e.mgr = m.empno 
    AND e.ename <> 'SCOTT';
    
--列出薪金比“SMITH”或“ALLEN”多的所有员工的编号、姓名、部门名称、其领导姓名，部门人数，平均工资、最高与最低工资。
SELECT e.empno, e.ename, d.dname, e.sal, m.ename mgr, temp.count, temp.avg, temp.max, temp.min
FROM emp e, dept d, emp m,
    (SELECT deptno dno, COUNT(empno) count, AVG(sal) avg, MAX(sal) max, MIN(sal) min FROM emp GROUP BY deptno) temp
WHERE e.sal > ANY(SELECT sal FROM emp WHERE ename IN ('SMITH' ,'ALLEN'))
    AND e.ename NOT IN ('SMITH' ,'ALLEN')
    AND d.deptno = e.deptno
    AND e.mgr = m.empno(+) 
    AND e.deptno = temp.dno ;
    
--列出受雇日期早于其直接上级的所有员工的编号、姓名、部门名称、部门位置、部门人数
 SELECT e.empno, e.ename, d.dname, d.loc, temp.count
 FROM emp e, emp m, dept d, (
        SELECT deptno dno, COUNT(empno) count
        FROM emp
        GROUP BY deptno) temp
 WHERE e.mgr = m.empno(+)
        AND e.hiredate<m.hiredate
        AND e.deptno = d.deptno
        AND d.deptno = temp.dno ;
        
--列出所有“CLERK”（办事员）的姓名及其部门名称，部门的人数，工资等级。
SELECT e.ename, e.job, e.sal, d.dname, temp.count, g.grade
FROM emp e, dept d, salgrade g, (
        SELECT deptno dno, COUNT(empno) count
        FROM emp
        GROUP BY deptno) temp
WHERE e.job = 'CLERK'
        AND e.deptno = d.deptno 
        AND d.deptno = temp.dno 
        AND e.sal BETWEEN g.losal AND g.hisal ;
        
--22，数据更新
--将emp表复制为myemp表(只有Oracle有这个操作)
CREATE TABLE myemp AS SELECT * FROM emp ;

--数据增加
-- INSERT INTO 表名称 [(列名称1，列名称2，...)] VALUES (值1，值2，...) ;
INSERT INTO myemp (empno, sal, job, comm, ename, mgr, hiredate, deptno)
VALUES (8888, 9000.0, '清洁工', 10.0, '张三', 7369, TO_DATE('1970-10-10', 'yyyy-mm-dd'), 40) ;

INSERT INTO myemp 
VALUES (9999, '李四', '清洁工', 7369, TO_DATE('1970-10-10', 'yyyy-mm-dd'), 9000.0, 10.0, 40) ;

--数据修改
-- UPDATE 表名称 SET 字段1 = 值1，字段2 = 值2，...[WHERE 更新条件(s)] ;
--将SMITH的工资修改为8000，佣金修改为9000
UPDATE myemp SET sal = 8000, comm = 9000 WHERE ename = 'SMITH' ;

--将ALLEN的工资修改为SCOTT的工资
UPDATE myemp SET sal = (
    SELECT sal FROM emp WHERE ename = 'SCOTT') WHERE ename = 'ALLEN' ;
    
--将低于公司平均工资的雇员工资上涨20%
UPDATE myemp SET sal =  sal * 1.2 
WHERE sal < (SELECT AVG(sal) FROM emp) ;

--将所有雇员的雇用日期修改为今天(只要是更新，必须要写WHERE子句)
UPDATE myemp SET hiredate = SYSDATE ; 

--数据删除
-- DELETE FROM 表名称 [WHERE 删除条件(s)] ;
--删除雇员编号是7566的雇员信息
DELETE FROM myemp WHERE empno = 7566 ;

--删除雇员编号是7782, 7902的雇员信息
DELETE FROM myemp WHERE empno IN (7782, 7902) ;

--删除高于公司平均工资的雇员信息
DELETE FROM myemp WHERE sal > (SELECT AVG(sal) FROM myemp) ;

--删除全部记录
DELETE FROM myemp ;

--23，事务处理,事务是针对于数据更新使用的
--Session(回话,表示唯一的一个登陆用户)
--commit 事务提交
--rollback 事务回滚操作
--认识死锁 只要是不同的Session进行同一条记录跟新时，会互相等待
DELETE FROM myemp WHERE empno=7369 ;
rollback ;
commit ;

--24，数据伪列
--ROWNUM 行号
SELECT ROWNUM, empno, ename, job
FROM emp ;

--取出第一行记录(只能是第一行)
SELECT *
FROM emp 
WHERE ROWNUM = 1;

--取出前N行记录(只能是前N行)
SELECT ROWNUM, empno, ename, job
FROM emp 
WHERE ROWNUM <= 5;

/*Oralce中实现数据分页的核心结构语法,开发中100%要用到
SELECT *
FROM (
    SELECT 列, ..., ROWNUM rn
    FROM 表名称, 表名称, ...
    WHERE ROWNUM <= (currentPage * lineSize)
    ORDER BY 字段...) temp
WHERE temp.rn > ((currentPage -1) * lineSize);
*/

--取出第6-10行数据的方法
SELECT *
FROM (SELECT ROWNUM rn , empno, ename, job
    FROM emp 
    WHERE ROWNUM <= 10) temp
WHERE temp.rn > 5;

--ROWID 行ID
SELECT ROWID, deptno, dname, loc FROM dept ;
SELECT * FROM dept WHERE ROWID = 'AAAR3qAAEAAAACHAAA' ;

--利用ROWID删除表中的重复行
CREATE TABLE mydept AS SELECT * FROM dept ;
INSERT INTO mydept(deptno, dname, loc) VALUES (10, 'ACCOUNTING', 'NEW YORK') ;
INSERT INTO mydept(deptno, dname, loc) VALUES (10, 'ACCOUNTING', 'NEW YORK') ;
INSERT INTO mydept(deptno, dname, loc) VALUES (10, 'ACCOUNTING', 'NEW YORK') ;
INSERT INTO mydept(deptno, dname, loc) VALUES (30, 'SALES', 'CHICAGO') ;
INSERT INTO mydept(deptno, dname, loc) VALUES (30, 'SALES', 'CHICAGO') ;

DELETE FROM mydept WHERE ROWID NOT IN (
    SELECT MIN(ROWID)
    FROM mydept
    GROUP BY deptno, dname, loc) ;

select * from mydept ;

--25，表的创建与管理
/*常见的数据类型 VARCHAR2(n)  NUMBER(n,m)  DATE  CLOB  BLOB
CREATE TABLE 表名称 (
    列名称 类型 [DEFAULT 默认值],
    列名称 类型 [DEFAULT 默认值],
    列名称 类型 [DEFAULT 默认值],
    ...
    列名称 类型 [DEFAULT 默认值]
);
*/
CREATE TABLE member(
    mid         NUMBER,
    name        VARCHAR2(50) DEFAULT '无名氏',
    age         NUMBER(3),
    birthday    DATE         DEFAULT SYSDATE,
    note        CLOB
);

INSERT INTO member (mid, name, age, birthday, note)
VALUES (10, '张三', 30, TO_DATE('1985-11-11', 'yyyy-mm-dd'), '是个人');

INSERT INTO member (mid, age, note)
VALUES (20, 20, '是个人') ;

--数据表的重命名（只有Oracle才有的命令）
--查询一个用户数据字典中所有的数据表(user_tables)
SELECT * FROM user_tables ;
SELECT table_name, tablespace_name FROM user_tables ;

--Oracle命令修改表名称
--RENAME 旧的表名称 TO 新的表名称 ;
--回退是不行的，一旦发了DDL操作，所有未提交的事务都会被提交
RENAME member TO person ;

--26，截断表，彻底清空表中的全部数据，无法回退（只有Oracle才有的命令）
--TRUNCATE TABLE 表名称 ;
TRUNCATE TABLE person ;

--27，复制表
--CREATE TABLE 表名称 AS 子查询 ;
--创建一张只包含10部门雇员信息的数据表
CREATE TABLE emp10 AS SELECT * FROM emp WHERE deptno = 10 ;

--根据子查询的结构创建新的表，并且将子查询的数据保存在新表中
CREATE TABLE emp20 AS SELECT empno, ename, sal FROM emp WHERE deptno = 20 ;

CREATE TABLE deptstat AS
SELECT d.deptno, d.dname, d.loc, temp.count, temp.avg
FROM dept d, (SELECT deptno dno, COUNT(empno) count, AVG(sal) avg FROM emp GROUP BY deptno) temp
WHERE d.deptno = temp.dno(+);

--复制emp的表结构，但是不复制里面的数据(不属于标准SQL)
CREATE TABLE empnull AS
SELECT * FROM emp WHERE 1=2 ;

--28，表的删除
-- DROP TABLE 表名称 ;
DROP TABLE deptstat ;
DROP TABLE emp10 ;
DROP TABLE emp20 ;
DROP TABLE empnull ;
DROP TABLE person ;
DROP TABLE mydept ;
DROP TABLE myemp ;

select * from tab ;

--29，闪回技术(Oracle的技术)
--类似windows的回收站，删除数据表后先保存在回收站中'BIN*'开头的表
--查看回收站
COL original_name FOR  A30;
COL object_name FOR A30;
COL droptime FOR A30;
SELECT original_name, object_name, droptime FROM user_recyclebin ;

--恢复删除的表
FLASHBACK TABLE deptstat TO BEFORE DROP;

--强制删除数据表
DROP TABLE deptstat PURGE ;

--删除回收站里的表
PURGE TABLE emp20 ;

--清空回收站
PURGE RECYCLEBIN;

--30，修改表结构
/*编写数据库脚本的要求：
脚本文件的后缀是"*.sql；
要编写删除数据表的语法；
创建数据表的语法；
测试数据；
执行事务提交。
*/

--删除数据表
DROP TABLE member PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(50)
) ;
--测试数据
INSERT INTO member (mid, name) VALUES (10, '张三') ;
INSERT INTO member (mid, name) VALUES (20, '李四') ;
--事务提交
COMMIT ;

/*增加表中的数据列
ALTER TABLE 表名称 ADD(
    列名称  类型  [DEFAULT 默认值],
    列名称  类型  [DEFAULT 默认值],...
) ;
*/
--添加一列，不设置默认值
ALTER TABLE member ADD (email VARCHAR2(20)) ;

--添加一列，设置默认值
ALTER TABLE member ADD (sex VARCHAR2(5) DEFAULT '男') ;

/*修改表中的数据列
ALTER TABLE 表名称 MODIFY(
    列名称  类型  [DEFAULT 默认值],
    列名称  类型  [DEFAULT 默认值],...
) ;
*/
ALTER TABLE member MODIFY(name VARCHAR2(20) DEFAULT '无名氏') ;

/*删除列
ALTER TABLE 表名称 DROP COLUMN 列
*/
ALTER TABLE member DROP COLUMN sex ;

--31，约束的创建与管理
--非空约束(NOT NULL , NK)
--脚本如下
--删除数据表
DROP TABLE member PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) NOT NULL
) ;
--增加正确的数据
INSERT INTO member (mid, name) VALUES (10, '张三') ;
--增加错误的数据
INSERT INTO member (mid, name) VALUES (20, null) ;

--唯一约束（UNIQUE, UK)
--脚本如下
--删除数据表
DROP TABLE member PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) NOT NULL ,
    email   VARCHAR2(30) UNIQUE
) ;
--增加正确的数据
INSERT INTO member (mid, name) VALUES (10, '张三') ;
INSERT INTO member (mid, name, email) VALUES (20, '李四', 'xxxx@163.com') ;
--空值不受唯一约束的限制
INSERT INTO member (mid, name) VALUES (60, '张三') ;
--增加错误的数据
INSERT INTO member (mid, name, email) VALUES (90, '王五', 'xxxx@163.com') ;

--查看数据表在数据字典中的约束
COL owner FOR A10 ;
COL constraint_name FOR A20 ;
COL table_name FOR A20 ;
SELECT owner, constraint_name, table_name FROM user_constraints;

--继续查看约束对象
COL owner FOR A10 ;
COL constraint_name FOR A20 ;
COL table_name FOR A20 ;
COL column_name FOR A20 ;
SELECT * FROM user_cons_columns;

--设置约束名称
--脚本如下
--删除数据表
DROP TABLE member PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) NOT NULL ,
    email   VARCHAR2(30) ,
    CONSTRAINT uk_email UNIQUE(email)
) ;
--增加正确的数据
INSERT INTO member (mid, name) VALUES (10, '张三') ;
INSERT INTO member (mid, name, email) VALUES (20, '李四', 'xxxx@163.com') ;
--空值不受唯一约束的限制
INSERT INTO member (mid, name) VALUES (60, '张三') ;
--增加错误的数据
INSERT INTO member (mid, name, email) VALUES (90, '王五', 'xxxx@163.com') ;

--主键约束(PRIMARY KEY, PK)
-- 唯一约束 + 非空约束
--脚本如下
--删除数据表
DROP TABLE member PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) NOT NULL ,
    CONSTRAINT pk_mid PRIMARY KEY(mid)
) ;
--增加正确的数据
INSERT INTO member (mid, name) VALUES (10, '张三') ;
--增加错误的数据
INSERT INTO member (mid, name) VALUES (10, '李四') ;
INSERT INTO member (mid, name) VALUES (null, '王五') ;

--复合主键（基本不用）
--脚本如下
--删除数据表
DROP TABLE member PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) NOT NULL ,
    CONSTRAINT pk_mid_name PRIMARY KEY(mid, name)
) ;
--增加正确的数据
INSERT INTO member (mid, name) VALUES (10, '张三') ;
INSERT INTO member (mid, name) VALUES (10, '李四') ;
INSERT INTO member (mid, name) VALUES (20, '张三') ;
--增加错误的数据
INSERT INTO member (mid, name) VALUES (20, '张三') ;

--检查约束（最好所有的检查都由程序来完成）
--脚本如下
--删除数据表
DROP TABLE member PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) ,
    age     NUMBER(3) ,
    CONSTRAINT ck_age CHECK (age BETWEEN 0 AND 250)
) ;
--增加正确的数据
INSERT INTO member (mid, name) VALUES (10, '张三') ;
INSERT INTO member (mid, name, age) VALUES (20, '李四', 20) ;
--增加错误的数据
INSERT INTO member (mid, name, age) VALUES (20, '李四', 998) ;

--外键约束
--脚本如下
--删除数据表
DROP TABLE member PURGE ;
DROP TABLE book PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) NOT NULL ,
    CONSTRAINT pk_mid PRIMARY KEY(mid)
) ;
CREATE TABLE book (
    bid     NUMBER ,
    title   VARCHAR2(20),
    mid     NUMBER ,
    CONSTRAINT pk_bid PRIMARY KEY(bid) ,
    CONSTRAINT fk_mid FOREIGN KEY(mid) REFERENCES member(mid)
);
--增加正确数据
INSERT INTO member(mid, name) VALUES (10, '张三') ;
INSERT INTO member(mid, name) VALUES (20, '李四') ;
INSERT INTO member(mid, name) VALUES (30, '王五') ;
INSERT INTO book(bid, title, mid) VALUES (10001, 'Java', 10) ;
INSERT INTO book(bid, title, mid) VALUES (10002, 'JSP', 10) ;
INSERT INTO book(bid, title, mid) VALUES (10003, 'MVC', 10) ;
INSERT INTO book(bid, title, mid) VALUES (20001, 'Oracle', 20) ;
INSERT INTO book(bid, title, mid) VALUES (20002, 'DB2', 20) ;
INSERT INTO book(bid, title, mid) VALUES (20003, 'Mongo', 20) ;
INSERT INTO book(bid, title, mid) VALUES (30001, 'jQuery', 30) ;
INSERT INTO book(bid, title, mid) VALUES (30002, 'AngularJS', 30) ;
--增加错误的数据
INSERT INTO book(bid, title, mid) VALUES (88888, '幽灵', 90) ;
--限制一：删除表时，如果有外键，必须先删除子表，再删除父表
--如果两张表有循环外键，需要强制删除
DROP TABLE member CASCADE CONSTRAINT ;
DROP TABLE book PURGE ;
PURGE RECYCLEBIN ;
--限制二：父表中作为子表关联的外键字段，必须设置为主键约束或者是唯一约束
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) NOT NULL 
) ;
CREATE TABLE book (
    bid     NUMBER ,
    title   VARCHAR2(20),
    mid     NUMBER ,
    CONSTRAINT pk_bid PRIMARY KEY(bid) ,
    CONSTRAINT fk_mid FOREIGN KEY(mid) REFERENCES member(mid)
);
--限制三：默认情况下，如果父表记录中有对应的子表记录，那么父表记录无法被删除
--删除数据表
DROP TABLE member PURGE ;
DROP TABLE book PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) NOT NULL ,
    CONSTRAINT pk_mid PRIMARY KEY(mid)
) ;
CREATE TABLE book (
    bid     NUMBER ,
    title   VARCHAR2(20),
    mid     NUMBER ,
    CONSTRAINT pk_bid PRIMARY KEY(bid) ,
    CONSTRAINT fk_mid FOREIGN KEY(mid) REFERENCES member(mid)
);
--增加正确数据
INSERT INTO member(mid, name) VALUES (10, '张三') ;
INSERT INTO member(mid, name) VALUES (20, '李四') ;
INSERT INTO member(mid, name) VALUES (30, '王五') ;
INSERT INTO book(bid, title, mid) VALUES (10001, 'Java', 10) ;
INSERT INTO book(bid, title, mid) VALUES (10002, 'JSP', 10) ;
INSERT INTO book(bid, title, mid) VALUES (10003, 'MVC', 10) ;
INSERT INTO book(bid, title, mid) VALUES (20001, 'Oracle', 20) ;
INSERT INTO book(bid, title, mid) VALUES (20002, 'DB2', 20) ;
INSERT INTO book(bid, title, mid) VALUES (20003, 'Mongo', 20) ;
INSERT INTO book(bid, title, mid) VALUES (30001, 'jQuery', 30) ;
INSERT INTO book(bid, title, mid) VALUES (30002, 'AngularJS', 30) ;
--删除member表中的数据
DELETE FROM member WHERE mid = 10 ;
--无法被删除，如果要删除，需要先删除子表数据后再删除
DELETE FROM book WHERE mid = 10 ;
DELETE FROM member WHERE mid = 10 ;

--级联删除，父表数据一删除自动删除对应的子表里的数据
--删除数据表
DROP TABLE book PURGE ;
DROP TABLE member PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) NOT NULL ,
    CONSTRAINT pk_mid PRIMARY KEY(mid)
) ;
CREATE TABLE book (
    bid     NUMBER ,
    title   VARCHAR2(20),
    mid     NUMBER ,
    CONSTRAINT pk_bid PRIMARY KEY(bid) ,
    CONSTRAINT fk_mid FOREIGN KEY(mid) REFERENCES member(mid) ON DELETE CASCADE
);
--增加正确数据
INSERT INTO member(mid, name) VALUES (10, '张三') ;
INSERT INTO member(mid, name) VALUES (20, '李四') ;
INSERT INTO member(mid, name) VALUES (30, '王五') ;
INSERT INTO book(bid, title, mid) VALUES (10001, 'Java', 10) ;
INSERT INTO book(bid, title, mid) VALUES (10002, 'JSP', 10) ;
INSERT INTO book(bid, title, mid) VALUES (10003, 'MVC', 10) ;
INSERT INTO book(bid, title, mid) VALUES (20001, 'Oracle', 20) ;
INSERT INTO book(bid, title, mid) VALUES (20002, 'DB2', 20) ;
INSERT INTO book(bid, title, mid) VALUES (20003, 'Mongo', 20) ;
INSERT INTO book(bid, title, mid) VALUES (30001, 'jQuery', 30) ;
INSERT INTO book(bid, title, mid) VALUES (30002, 'AngularJS', 30) ;
--删除父表数据的同时自动删除对应的子表数据
DELETE FROM member WHERE mid = 10 ;

--级联更新，当父表数据被删除之后，子表对应的数据被设置为空
--删除数据表
DROP TABLE book PURGE ;
DROP TABLE member PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20) NOT NULL ,
    CONSTRAINT pk_mid PRIMARY KEY(mid)
) ;
CREATE TABLE book (
    bid     NUMBER ,
    title   VARCHAR2(20),
    mid     NUMBER ,
    CONSTRAINT pk_bid PRIMARY KEY(bid) ,
    CONSTRAINT fk_mid FOREIGN KEY(mid) REFERENCES member(mid) ON DELETE SET NULL
);
--增加正确数据
INSERT INTO member(mid, name) VALUES (10, '张三') ;
INSERT INTO member(mid, name) VALUES (20, '李四') ;
INSERT INTO member(mid, name) VALUES (30, '王五') ;
INSERT INTO book(bid, title, mid) VALUES (10001, 'Java', 10) ;
INSERT INTO book(bid, title, mid) VALUES (10002, 'JSP', 10) ;
INSERT INTO book(bid, title, mid) VALUES (10003, 'MVC', 10) ;
INSERT INTO book(bid, title, mid) VALUES (20001, 'Oracle', 20) ;
INSERT INTO book(bid, title, mid) VALUES (20002, 'DB2', 20) ;
INSERT INTO book(bid, title, mid) VALUES (20003, 'Mongo', 20) ;
INSERT INTO book(bid, title, mid) VALUES (30001, 'jQuery', 30) ;
INSERT INTO book(bid, title, mid) VALUES (30002, 'AngularJS', 30) ;
--删除父表数据的同时自动删除对应的子表数据
DELETE FROM member WHERE mid = 10 ;

--约束修改(不建议使用)
--可以用在检查、唯一、主键、外键约束上，不能用在非空约束上
--删除数据表
DROP TABLE book PURGE ;
DROP TABLE member PURGE ;
--创建数据表
CREATE TABLE member (
    mid     NUMBER ,
    name    VARCHAR2(20)
) ;
--增加数据
INSERT INTO member(mid, name) VALUES (10, null) ;
INSERT INTO member(mid, name) VALUES (10, '张三') ;
INSERT INTO member(mid, name) VALUES (10, '李四') ;
--为表中增加约束
--ALTER TABLE 表名称 ADD CONSTRAINT 约束名称 约束类型(字段)[选项] ;
DELETE FROM member WHERE name IN ('张三', '李四') ;
ALTER TABLE member ADD CONSTRAINT pk_mid PRIMARY KEY(mid) ;
--增加错误的数据
INSERT INTO member(mid, name) VALUES (10, '张三') ;
--增加非空约束(错误)
ALTER TABLE member ADD CONSTRAINT nk_name NOT NULL(name) ;
--如果要修改，只能通过修改表结构
DELETE FROM member ;
ALTER TABLE member MODIFY (name VARCHAR2(20) NOT NULL) ;
--为表删除约束
--ALTER TABLE 表名称 DROP CONSTRAINT 约束名称 ;
ALTER TABLE member DROP CONSTRAINT pk_mid ;
--删除非空约束
ALTER TABLE member MODIFY (name VARCHAR2(20)) ;
COL owner FOR A10 ;
COL constraint_name FOR A20 ;
COL table_name FOR A20 ;
SELECT owner, constraint_name, table_name FROM user_constraints;
ALTER TABLE member DROP CONSTRAINT SYS_C0011150;

/*32，序列创建
CREATE SEQUENCE 序列名称
[INCREMENT BY 步长] [START WITH 开始值]
[MAXVALUE 最大值 | NOMAXVALUE]
[MINVALUE 最小值 | NOMINVALUE]
[CYCLE | NOCYCLE]
[CACHE 缓存数据 | NOCACHE] ;
*/
--创建序列
CREATE SEQUENCE myseq ;
--查询序列
SELECT * FROM user_sequences ;
--使用序列
--序列对象.nextval
SELECT myseq.nextval FROM dual ;
--序列对象.currval
SELECT myseq.currval FROM dual ;
SELECT * FROM user_sequences ;
--为表中某个字段进行自动编号，不能写在创建脚本里
DROP TABLE mytab;
CREATE TABLE mytab (
    id      NUMBER,
    name    VARCHAR2(20),
    CONSTRAINT pk_id PRIMARY KEY (id)
);
INSERT INTO mytab(id,name) VALUES (myseq.nextval, 'xxx') ;
INSERT INTO mytab(id,name) VALUES (myseq.nextval, 'xxx') ;
INSERT INTO mytab(id,name) VALUES (myseq.nextval, 'xxx') ;
SELECT * FROM mytab ;
--修改序列步长为2
DROP SEQUENCE myseq ;
CREATE SEQUENCE myseq 
INCREMENT BY 2 ;
--修改序列的开始值
DROP SEQUENCE myseq ;
CREATE SEQUENCE myseq 
INCREMENT BY 2 
START WITH 10000000000000 ;
SELECT TO_CHAR(myseq.nextval, 99999999999999999999) FROM dual ;
--设置循环序列
DROP SEQUENCE myseq ;
CREATE SEQUENCE myseq 
INCREMENT BY 2 
START WITH 1
MINVALUE 1
MAXVALUE 9
CYCLE 
CACHE 3;

--33、同义词(Oracle独有)
--dual表是sys.dual表的一个别名
--创建同义词
--CREATE [PUBLIC] SYNONYM 同义词的名称 FOR 用户名.表名称 ;
CONN sys/change_on_install AS SYSDBA
CREATE SYNONYM myemp FOR scott.emp ;
SELECT * FROM myemp ;
--切换用户后，无法使用这个同义词
CONN system/manager
SELECT * FROM myemp ;
--如果想给其他用户使用，需创建公共同义词
CONN sys/change_on_install AS SYSDBA
DROP SYNONYM myemp ;
CREATE PUBLIC SYNONYM myemp FOR scott.emp ;
CONN system/manager
SELECT * FROM myemp ;

--34、视图(建议创建只读视图)
--视图就是包装了复杂查询的SQL语句对象
--为scott用户授予创建视图的权限
CONN sys/change_on_install AS SYSDBA
GRANT CREATE VIEW TO scott ;
CONN scott/tiger
--创建视图
--CREATE [OR REPLACE] VIEW 视图名称 AS 子查询 ;
CREATE VIEW myview AS
SELECT d.deptno, d.dname, d.loc, temp.count, temp.avg
FROM dept d, (
    SELECT deptno dno, COUNT(empno) count, AVG(sal) avg
    FROM emp
    GROUP BY deptno) temp
WHERE d.deptno = temp.dno(+) ;
--查看视图
SELECT view_name, text_length, text  FROM user_views ;
--使用视图
SELECT * FROM myview ;
--替换视图数据
CREATE OR REPLACE VIEW myview AS
SELECT * FROM emp WHERE deptno = 20 ;
--更新视图的创建条件,影响到了emp表
UPDATE myview SET deptno = 40 WHERE empno = 7369;
--为了保护视图的创建条件不被更新，使用WITH CHECK OPTION
ROLLBACK ;
CREATE OR REPLACE VIEW myview AS
SELECT * FROM emp WHERE deptno = 20 
WITH CHECK OPTION ;
UPDATE myview SET deptno = 40 WHERE empno = 7369;
--更新视图的非创建条件,也影响到了emp表
UPDATE myview SET sal = 99999 WHERE empno = 7369;
--为了保护视图不被更新，使用WITH READ ONLY
ROLLBACK ;
CREATE OR REPLACE VIEW myview AS
SELECT * FROM emp WHERE deptno = 20 
WITH READ ONLY ;
UPDATE myview SET sal = 99999 WHERE empno = 7369;
--删除视图
DROP VIEW myview ;

--35、索引的基本概念
--打开跟踪器
CONN sys/change_on_install AS SYSDBA
SET AUTOTRACE ON
--发出查询指令
SELECT * FROM scott.emp WHERE sal > 2000 ;
CONN scott/tiger
--创建索引
CREATE INDEX emp_sal_ind ON scott.emp(sal) ;
--加入索引后，不再执行全表扫描
CONN sys/change_on_install AS SYSDBA
SET AUTOTRACE ON
SELECT * FROM scott.emp WHERE sal > 2000 ;

--36、用户管理
--1、首先需要管理员操作
CONN sys/change_on_install AS SYSDBA
--2、创建一个新的用户 dog / wangwang 
CREATE USER dog IDENTIFIED BY wangwang ;
--3、为dog用户分配“CREATE SESSION” 权限；
GRANT CREATE SESSION TO dog ;
--4，继续为dog用户分配权限
GRANT CREATE TABLE TO dog ;
--5、为dog用户分配角色
GRANT CONNECT, RESOURCE TO dog ;
--一个用户的权限或角色发生变化后，要重新登录
--6、用户管理
--修改用户密码
ALTER USER dog IDENTIFIED BY miaomiao ;
--让密码失效，即登录之后立即需要修改密码
ALTER USER dog PASSWORD EXPIRE  ;
--锁定dog用户
ALTER USER dog ACCOUNT LOCK ;
--解锁dog用户
ALTER USER dog ACCOUNT UNLOCK ;
--7、将scott用户的操作对象权限授予其他用户
GRANT SELECT, INSERT ON scott.emp TO dog ;
--8、回收dog的权限
REVOKE CONNECT, RESOURCE FROM dog ;
REVOKE CREATE SESSION, CREATE TABLE FROM dog ;
--9、删除dog用户
DROP USER dog CASCADE ;
