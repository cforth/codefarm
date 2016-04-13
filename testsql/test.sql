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
