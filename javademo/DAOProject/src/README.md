#一、DAO设计模式 - 实例分析

现在要求使用emp表（empno、ename、job、hiredate、sal、comm）实现如下的操作功能：

1. 【业务层】实现雇员数据的添加，但是需要保证被添加的雇员编号不会重复； 
    * 【数据层】判断要增加的雇员编号是否存在； 
    * 【数据层】如果雇员编号不存在则进行数据的保存操作； 

2. 【业务层】实现雇员数据的修改操作； 
    * 【数据层】执行数据的修改操作； 

3. 【业务层】实现多个雇员数据的删除操作； 
    * 【数据层】执行雇员的限定删除操作； 

4. 【业务层】可以根据雇员编号查找到一个雇员的信息； 
    * 【数据层】根据雇员编号查询指定的雇员数据； 

5. 【业务层】可以查询所有雇员的信息； 
    * 【数据层】查询全部雇员数据； 

6. 【业务层】可以实现数据的分页显示（模糊查询），同时又可以返回所有的雇员数量。 
    * 【数据层】雇员数据的分页查询； 
    * 【数据层】使用COUNT()函数统计雇员数量。 
    
结论：用户提出的所有的需求都应该划分为业务层，因为他值得是功能，而开发人员必须根据业务层进行数据层的设计。


#二、项目准备

首先可以设置一个项目名称：DAOProject，并且由于此项目需要使用Oracle数据库，需要为其配置好数据库的驱动程序。并打开数据库的监听与实例化服务。

为方便的进行程序的统一管理，所有的项目的父包名称统一设置为：com.cfxyz。而子包要根据不同的模块划分。

##1、数据库连接类

本次操作己任要进行数据库的开发，那么必须进行数据库的连接操作与关闭才能正常操作，几乎所有的数据库连接操作都固定的步骤，那么可以单独定义一个DatabaseConnection类，这个类主要负责数据库连接对象的取得以及数据库的关闭操作。

[数据库连接类 DatabaseConnection](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dbc/DatabaseConnection.java)

整个的操作过程之中，DatabaseConnection只是无条件的提供数据库连接，而有多少个线程需要找到此类连接对象，它都不关心。

最早的DAO设计模式还会考虑到多数据库之间的移植问题，此时就需要设置一个专门的表示连接操作的接口。考虑到现实开发中，所提供的第三方的框架平台越来越完善，这种复杂设计就慢慢被忽略掉了。  

##2、开发 Value Object

现在的程序严格来讲，已经给出了四个层次（显示层、控制层、业务层、数据层）。不同层次之间一定要进行数据的传递，但是既然要操作的是指定的数据表，所以数据的结构必须要与表的结构一一对应，那么自然就可以想到简单Java类（po、to、pojo、vo）。

在实际的工作之中，针对于简单Java类的开发给出如下的要求：

1. 考虑到有可能出现的分布式应用问题，所以简单Java类必须要实现java.io.Serializable接口；

2. 简单Java类的名称必须与表名称保持一致；   
	* 有可能采用这样的名字：student_info，类名称为：StudentInfo；  
	
3. 类中的属性不允许使用基本数据类型，都必须使用基本数据类型的包装类；  
	* 基本数据类型的默认值是0，而如果是包装类默认值为null；  

4. 类中的属性必须使用private封装，封装后的属性必须要提供setter、getter；   

5. 类中可以定义有多个构造方法，但必须要保留有一个无参构造方法；

6. 【可选要求，基本不用】覆写equals()、toString()、hashCode();  

将所有的简单Java类保存在vo包中。

[简单Java类 Emp](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/vo/Emp.java)

不管有多少张表，只要是实体表，那么一定要写简单Java类，而且不要试图想着一次性将所有的表都转换到位。

#三、开发数据层

数据层最终是交给业务层进行调用的，所以业务层必须知道数据层的执行标准，即：业务层需要明确的知道数据层的操作方法， 但是不需要知道它的具体实现。

##1、开发数据层操作标准

不同层之间要进行访问，必须提供有接口，以定义操作标准，那么对于数据层也是一样的。因为数据层最终是要交给业务层执行，所以需要先定义数据层的接口。

对于数据层的接口，给出如下的开发要求：

1. 数据层既然是进行数据操作的，就将其保存在dao包下；  

2. 既然不同的数据表操作有可能使用不同的数据层开发，那么就针对于数据表进行命名；  
	* emp表，那么数据层的接口就应该定义为IEmpDAO；  

3. 对于整个数据层的开发严格来讲就只有两类功能；  
	* 数据更新：建议它的操作方法以doXxx()的形式命名，例如：doCreate()、doUpdata()、doRemove()；  
	* 数据查询：对于查询分为两种形式：  
		* 查询表中数以findXxx()形式命名，例如：findById()、findByName()、findAll();  
		* 统计表中的数据以getXxx()形式命名，例如getAllCount()；  

[定义IEmpDAO接口](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dao/IEmpDAO.java)

##2、数据层实现类

数据层需要被业务层调用，数据层需要进行数据库的执行（PreparedStatement），由于在开发之中一个业务层操作需要执行多个数据层的调用，所以数据库的打开与关闭操作应该由业务层控制比较合理。

所有的数据层实现类要求保存在dao.impl子包下。

[EmpDAOImpl子类](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dao/impl/EmpDAOImpl.java)

子类里面唯一需要注意的就是构造方法一定要接收一个Connection的接口对象。

##3、定义数据层工厂类 -- DAOFactory

业务层要想进行数据层的调用，那么必须要取得IEmpDAO接口对象，但是不同层之间如果要想取得接口对象实例，需要使用工厂设计模式，这个工厂类保存在factory子包下。

[定义工厂类](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/factory/DAOFactory.java)

#四、开发业务层

业务层是真正留给外部调用的，可能是控制层，或者是直接调用，既然业务层是是由不同的层进行调用，所以业务层开发的首要任务就是定义业务层的操作标准。

##1、开发业务层标准 -- IEmpService

业务层也称为Service层，既然描述的是emp表的操作，所以名称为IEmpService，保存在service子包下，但是对于业务层的方法定义并没有明确要求，建议还是使用统一名称：

[定义IEmpService操作标准](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/service/IEmpService.java)

本接口中方法的设计完全符合之前的分析过程

##2、业务层实现类

业务层实现类的核心功能：

1. 负责控制数据库的打开与关闭，当存在了业务层对象后，就是为了操作数据库，即：业务层对象实例化之后就必须准备好数据库连接；

2. 根据DAOFactory调用getIEmpDAOInstance()方法而后取得IEmpDAO接口对象

业务层的实现类保存在dao.impl子包中。

[定义EmpServiceImpl子类](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/service/impl/EmpServiceImpl.java)

不同层之间的访问依靠的是工厂类和接口进行操作。

##3、定义业务层工厂类 -- ServiceFactory

业务层最终依然需要被其它的层所使用，所以需要为其定义工厂类，该类也放在factory子包下。如果从实际的开发来讲，业务层应该分为两种：

1. 前台业务逻辑：可以保存在service.front包中，工厂类：ServiceFrontFactory;

2. 后台业务逻辑：可以保存在service.back包中，工厂类：ServiceBackFactory。

[定义ServiceFactory](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/factory/ServiceFactory.java)

在实际的编写之中，子类永远都是不可见的，同时在整个操作里面，控制层完全看不见数据库的任何操作（没有任何JDBC代码）。

#五、代码测试

因为最终的业务层是需要用户去调用，所以测试分为两种。

##1、调用测试

安装传统方式产生对象，而后调用里面的方法进行操作。保存在test子包内。

1. [测试增加操作](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/test/TestEmpInsert.java)

2. [测试分页查询功能](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/test/TestEmpSplit.java)

整个的操作流程客户端的调用非常容易，不需要涉及到具体的数据存储细节。

##2、利用junit进行测试

对于这种业务的测试，使用junit是最好的选择。

首先要选择测试的类或接口，现在选择好IEmpService接口进行测试。

[测试代码](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/test/junit/IEmpServiceTest.java)

此时测试就正常通过了。

#六、实现部门操作

要求使用部门表（dept）实现如下的功能：

1. 【业务层】进行部门数据的添加；  
	* 【数据层】判断要增加的部门编号是否存在，如果不存在则可以添加；   
	* 【数据层】实现部门数据的保存；  

2. 【业务层】进行部门数据的修改；  
	* 【数据层】进行部门数据的修改；  

3. 【业务层】进行部门数据的删除；  
	* 【数据层】进行部门数据的删除；  
	
4. 【业务层】进行部门数据的全部查询；  
	* 【数据层】查询全部；  

5. 【业务层】可以根据部门编号查询一个部门完整信息；  
	* 【数据层】根据编号查询。  
	
	
1、依然要定义[Dept.java类](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/vo/Dept.java)

2、定义IDeptDAO接口

几乎所有的数据表都应该具备有基础CRUD功能（增加、修改全部、删除数据、根据编号查询、查询全部、分页显示、数据统计），那么这些功能的方法每个接口都要重复定义。

在整个DAO接口定义的过程之中，不同的表区在于：VO类、主键类型。为了消除重复，使用泛型接口的继承操作。

[IDAO泛型接口](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dao/IDAO.java)

[定义IDeptDAO子接口](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dao/IDeptDAO.java)

3、定义[DeptDAOImpl子类](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dao/impl/DeptDAOImpl.java)

4、修改DAOFactory类，增加新的接口对象取得方法;

5、开发[IDeptService](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/service/IDeptService.java)接口；

6、实现[DeptServiceImpl子类](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/service/impl/DeptServiceImpl.java);

7、修改服务层工厂类

在使用之前还是进行[一些测试](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/test/junit/IDeptServiceTest.java)。

