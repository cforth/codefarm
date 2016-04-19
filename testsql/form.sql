--第一设计范式(单表)
--数据表中的每个字段都不可再分。例如：
CREATE TABLE member (
    mid     NUMBER,
    name    VARCHAR2(50),
    email   VARCHAR2(50),
    tel     VARCHAR2(50),
    mobile  VARCHAR2(50),
    CONSTRAINT pk_mid PRIMARY KEY(mid)
);

--第二范式(多对多关系映射)
--数据表之中不存在非关键字段对任意一候选关键字段的部分函数依赖。
--1、数据表中两列之间不存在函数关系
--2、数据表中两列之间不存在依赖关系

--根据第一范式设计学生选课表
CREATE TABLE student_course(
    stuid       NUMBER ,
    sname       VARCHAR2(50),
    ctitle      VARCHAR2(50),
    credit      NUMBER,
    score       NUMBER,
    CONSTRAINT pk_stuid PRIMARY KEY(stuid)
) ;

--以上代码有缺陷，根据第二范式改进如下
CREATE TABLE student (
    stuid       NUMBER,
    sname       VARCHAR2(50),
    CONSTRAINT pk_stuid PRIMARY KEY(stuid)
);

CREATE TABLE course (
    cid         NUMBER,
    ctitle      VARCHAR2(50),
    credit      NUMBER,
    CONSTRAINT pk_cid PRIMARY KEY(cid)
);

CREATE TABLE student_course (
    stuid       NUMBER REFERENCES student(stuid) ON DELETE CASCADE,
    cid         NUMBER REFERENCES course(cid)  ON DELETE CASCADE,
    score       NUMBER
);

INSERT INTO student VALUES (1, '张三');
INSERT INTO student VALUES (2, '李四');
INSERT INTO student VALUES (3, '王五');
INSERT INTO course VALUES (10, '马克思主义哲学');
INSERT INTO course VALUES (11, 'Java');
INSERT INTO course VALUES (12, 'Oracle');
INSERT INTO student_course VALUES (1,10,90) ;
INSERT INTO student_course VALUES (2,11,89) ;
INSERT INTO student_course VALUES (1,11,99) ;
INSERT INTO student_course VALUES (3,11,98) ;

--第三范式(一对多)
--数据表之中不存在非关键字段对任意一候选关键字段的传递函数依赖。
--要求设计一张表，可以描述一个学校有多个学生
CREATE TABLE school (
    schid       NUMBER ,
    name        VARCHAR2(50) ,
    address     VARCHAR2(200) ,
    tel         VARCHAR2(50) ,
    CONSTRAINT pk_schid PRIMARY KEY(schid)
);

CREATE TABLE student (
    sid         NUMBER ,
    sname       VARCHAR2(50) ,
    schid       NUMBER REFERENCES school(schid)
);
