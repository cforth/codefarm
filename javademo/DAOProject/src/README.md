#һ��DAO���ģʽ - ʵ������

����Ҫ��ʹ��emp��empno��ename��job��hiredate��sal��comm��ʵ�����µĲ������ܣ�

1. ��ҵ��㡿ʵ�ֹ�Ա���ݵ���ӣ�������Ҫ��֤����ӵĹ�Ա��Ų����ظ��� 
    * �����ݲ㡿�ж�Ҫ���ӵĹ�Ա����Ƿ���ڣ� 
    * �����ݲ㡿�����Ա��Ų�������������ݵı�������� 

2. ��ҵ��㡿ʵ�ֹ�Ա���ݵ��޸Ĳ����� 
    * �����ݲ㡿ִ�����ݵ��޸Ĳ����� 

3. ��ҵ��㡿ʵ�ֶ����Ա���ݵ�ɾ�������� 
    * �����ݲ㡿ִ�й�Ա���޶�ɾ�������� 

4. ��ҵ��㡿���Ը��ݹ�Ա��Ų��ҵ�һ����Ա����Ϣ�� 
    * �����ݲ㡿���ݹ�Ա��Ų�ѯָ���Ĺ�Ա���ݣ� 

5. ��ҵ��㡿���Բ�ѯ���й�Ա����Ϣ�� 
    * �����ݲ㡿��ѯȫ����Ա���ݣ� 

6. ��ҵ��㡿����ʵ�����ݵķ�ҳ��ʾ��ģ����ѯ����ͬʱ�ֿ��Է������еĹ�Ա������ 
    * �����ݲ㡿��Ա���ݵķ�ҳ��ѯ�� 
    * �����ݲ㡿ʹ��COUNT()����ͳ�ƹ�Ա������ 
    
���ۣ��û���������е�����Ӧ�û���Ϊҵ��㣬��Ϊ��ֵ���ǹ��ܣ���������Ա�������ҵ���������ݲ����ơ�


#������Ŀ׼��

���ȿ�������һ����Ŀ���ƣ�DAOProject���������ڴ���Ŀ��Ҫʹ��Oracle���ݿ⣬��ҪΪ�����ú����ݿ���������򡣲������ݿ�ļ�����ʵ��������

Ϊ����Ľ��г����ͳһ�������е���Ŀ�ĸ�������ͳһ����Ϊ��com.cfxyz�����Ӱ�Ҫ���ݲ�ͬ��ģ�黮�֡�

##1�����ݿ�������

���β�������Ҫ�������ݿ�Ŀ�������ô����������ݿ�����Ӳ�����رղ��������������������е����ݿ����Ӳ������̶��Ĳ��裬��ô���Ե�������һ��DatabaseConnection�࣬�������Ҫ�������ݿ����Ӷ����ȡ���Լ����ݿ�Ĺرղ�����

[���ݿ������� DatabaseConnection](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dbc/DatabaseConnection.java)

�����Ĳ�������֮�У�DatabaseConnectionֻ�����������ṩ���ݿ����ӣ����ж��ٸ��߳���Ҫ�ҵ��������Ӷ������������ġ�

�����DAO���ģʽ���ῼ�ǵ������ݿ�֮�����ֲ���⣬��ʱ����Ҫ����һ��ר�ŵı�ʾ���Ӳ����Ľӿڡ����ǵ���ʵ�����У����ṩ�ĵ������Ŀ��ƽ̨Խ��Խ���ƣ����ָ�����ƾ����������Ե��ˡ�  

##2������ Value Object

���ڵĳ����ϸ��������Ѿ��������ĸ���Σ���ʾ�㡢���Ʋ㡢ҵ��㡢���ݲ㣩����ͬ���֮��һ��Ҫ�������ݵĴ��ݣ����Ǽ�ȻҪ��������ָ�������ݱ��������ݵĽṹ����Ҫ���Ľṹһһ��Ӧ����ô��Ȼ�Ϳ����뵽��Java�ࣨpo��to��pojo��vo����

��ʵ�ʵĹ���֮�У�����ڼ�Java��Ŀ����������µ�Ҫ��

1. ���ǵ��п��ܳ��ֵķֲ�ʽӦ�����⣬���Լ�Java�����Ҫʵ��java.io.Serializable�ӿڣ�

2. ��Java������Ʊ���������Ʊ���һ�£�   
	* �п��ܲ������������֣�student_info��������Ϊ��StudentInfo��  
	
3. ���е����Բ�����ʹ�û����������ͣ�������ʹ�û����������͵İ�װ�ࣻ  
	* �����������͵�Ĭ��ֵ��0��������ǰ�װ��Ĭ��ֵΪnull��  

4. ���е����Ա���ʹ��private��װ����װ������Ա���Ҫ�ṩsetter��getter��   

5. ���п��Զ����ж�����췽����������Ҫ������һ���޲ι��췽����

6. ����ѡҪ�󣬻������á���дequals()��toString()��hashCode();  

�����еļ�Java�ౣ����vo���С�

[��Java�� Emp](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/vo/Emp.java)

�����ж����ű�ֻҪ��ʵ�����ôһ��Ҫд��Java�࣬���Ҳ�Ҫ��ͼ����һ���Խ����еı�ת����λ��

#�����������ݲ�

���ݲ������ǽ���ҵ�����е��õģ�����ҵ������֪�����ݲ��ִ�б�׼������ҵ�����Ҫ��ȷ��֪�����ݲ�Ĳ��������� ���ǲ���Ҫ֪�����ľ���ʵ�֡�

##1���������ݲ������׼

��ͬ��֮��Ҫ���з��ʣ������ṩ�нӿڣ��Զ��������׼����ô�������ݲ�Ҳ��һ���ġ���Ϊ���ݲ�������Ҫ����ҵ���ִ�У�������Ҫ�ȶ������ݲ�Ľӿڡ�

�������ݲ�Ľӿڣ��������µĿ���Ҫ��

1. ���ݲ��Ȼ�ǽ������ݲ����ģ��ͽ��䱣����dao���£�  

2. ��Ȼ��ͬ�����ݱ�����п���ʹ�ò�ͬ�����ݲ㿪������ô����������ݱ����������  
	* emp����ô���ݲ�Ľӿھ�Ӧ�ö���ΪIEmpDAO��  

3. �����������ݲ�Ŀ����ϸ�������ֻ�����๦�ܣ�  
	* ���ݸ��£��������Ĳ���������doXxx()����ʽ���������磺doCreate()��doUpdata()��doRemove()��  
	* ���ݲ�ѯ�����ڲ�ѯ��Ϊ������ʽ��  
		* ��ѯ��������findXxx()��ʽ���������磺findById()��findByName()��findAll();  
		* ͳ�Ʊ��е�������getXxx()��ʽ����������getAllCount()��  

[����IEmpDAO�ӿ�](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dao/IEmpDAO.java)

##2�����ݲ�ʵ����

���ݲ���Ҫ��ҵ�����ã����ݲ���Ҫ�������ݿ��ִ�У�PreparedStatement���������ڿ���֮��һ��ҵ��������Ҫִ�ж�����ݲ�ĵ��ã��������ݿ�Ĵ���رղ���Ӧ����ҵ�����ƱȽϺ���

���е����ݲ�ʵ����Ҫ�󱣴���dao.impl�Ӱ��¡�

[EmpDAOImpl����](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dao/impl/EmpDAOImpl.java)

��������Ψһ��Ҫע��ľ��ǹ��췽��һ��Ҫ����һ��Connection�Ľӿڶ���

##3���������ݲ㹤���� -- DAOFactory

ҵ���Ҫ��������ݲ�ĵ��ã���ô����Ҫȡ��IEmpDAO�ӿڶ��󣬵��ǲ�ͬ��֮�����Ҫ��ȡ�ýӿڶ���ʵ������Ҫʹ�ù������ģʽ����������ౣ����factory�Ӱ��¡�

[���幤����](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/factory/DAOFactory.java)

#�ġ�����ҵ���

ҵ��������������ⲿ���õģ������ǿ��Ʋ㣬������ֱ�ӵ��ã���Ȼҵ��������ɲ�ͬ�Ĳ���е��ã�����ҵ��㿪������Ҫ������Ƕ���ҵ���Ĳ�����׼��

##1������ҵ����׼ -- IEmpService

ҵ���Ҳ��ΪService�㣬��Ȼ��������emp��Ĳ�������������ΪIEmpService��������service�Ӱ��£����Ƕ���ҵ���ķ������岢û����ȷҪ�󣬽��黹��ʹ��ͳһ���ƣ�

[����IEmpService������׼](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/service/IEmpService.java)

���ӿ��з����������ȫ����֮ǰ�ķ�������

##2��ҵ���ʵ����

ҵ���ʵ����ĺ��Ĺ��ܣ�

1. ����������ݿ�Ĵ���رգ���������ҵ������󣬾���Ϊ�˲������ݿ⣬����ҵ������ʵ����֮��ͱ���׼�������ݿ����ӣ�

2. ����DAOFactory����getIEmpDAOInstance()��������ȡ��IEmpDAO�ӿڶ���

ҵ����ʵ���ౣ����dao.impl�Ӱ��С�

[����EmpServiceImpl����](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/service/impl/EmpServiceImpl.java)

��ͬ��֮��ķ����������ǹ�����ͽӿڽ��в�����

##3������ҵ��㹤���� -- ServiceFactory

ҵ���������Ȼ��Ҫ�������Ĳ���ʹ�ã�������ҪΪ�䶨�幤���࣬����Ҳ����factory�Ӱ��¡������ʵ�ʵĿ���������ҵ���Ӧ�÷�Ϊ���֣�

1. ǰ̨ҵ���߼������Ա�����service.front���У������ࣺServiceFrontFactory;

2. ��̨ҵ���߼������Ա�����service.back���У������ࣺServiceBackFactory��

[����ServiceFactory](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/factory/ServiceFactory.java)

��ʵ�ʵı�д֮�У�������Զ���ǲ��ɼ��ģ�ͬʱ�������������棬���Ʋ���ȫ���������ݿ���κβ�����û���κ�JDBC���룩��

#�塢�������

��Ϊ���յ�ҵ�������Ҫ�û�ȥ���ã����Բ��Է�Ϊ���֡�

##1�����ò���

��װ��ͳ��ʽ�������󣬶����������ķ������в�����������test�Ӱ��ڡ�

1. [�������Ӳ���](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/test/TestEmpInsert.java)

2. [���Է�ҳ��ѯ����](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/test/TestEmpSplit.java)

�����Ĳ������̿ͻ��˵ĵ��÷ǳ����ף�����Ҫ�漰����������ݴ洢ϸ�ڡ�

##2������junit���в���

��������ҵ��Ĳ��ԣ�ʹ��junit����õ�ѡ��

����Ҫѡ����Ե����ӿڣ�����ѡ���IEmpService�ӿڽ��в��ԡ�

[���Դ���](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/test/junit/IEmpServiceTest.java)

��ʱ���Ծ�����ͨ���ˡ�

#����ʵ�ֲ��Ų���

Ҫ��ʹ�ò��ű�dept��ʵ�����µĹ��ܣ�

1. ��ҵ��㡿���в������ݵ���ӣ�  
	* �����ݲ㡿�ж�Ҫ���ӵĲ��ű���Ƿ���ڣ�����������������ӣ�   
	* �����ݲ㡿ʵ�ֲ������ݵı��棻  

2. ��ҵ��㡿���в������ݵ��޸ģ�  
	* �����ݲ㡿���в������ݵ��޸ģ�  

3. ��ҵ��㡿���в������ݵ�ɾ����  
	* �����ݲ㡿���в������ݵ�ɾ����  
	
4. ��ҵ��㡿���в������ݵ�ȫ����ѯ��  
	* �����ݲ㡿��ѯȫ����  

5. ��ҵ��㡿���Ը��ݲ��ű�Ų�ѯһ������������Ϣ��  
	* �����ݲ㡿���ݱ�Ų�ѯ��  
	
	
1����ȻҪ����[Dept.java��](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/vo/Dept.java)

2������IDeptDAO�ӿ�

�������е����ݱ�Ӧ�þ߱��л���CRUD���ܣ����ӡ��޸�ȫ����ɾ�����ݡ����ݱ�Ų�ѯ����ѯȫ������ҳ��ʾ������ͳ�ƣ�����ô��Щ���ܵķ���ÿ���ӿڶ�Ҫ�ظ����塣

������DAO�ӿڶ���Ĺ���֮�У���ͬ�ı������ڣ�VO�ࡢ�������͡�Ϊ�������ظ���ʹ�÷��ͽӿڵļ̳в�����

[IDAO���ͽӿ�](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dao/IDAO.java)

[����IDeptDAO�ӽӿ�](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dao/IDeptDAO.java)

3������[DeptDAOImpl����](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/dao/impl/DeptDAOImpl.java)

4���޸�DAOFactory�࣬�����µĽӿڶ���ȡ�÷���;

5������[IDeptService](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/service/IDeptService.java)�ӿڣ�

6��ʵ��[DeptServiceImpl����](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/service/impl/DeptServiceImpl.java);

7���޸ķ���㹤����

��ʹ��֮ǰ���ǽ���[һЩ����](https://github.com/cforth/codefarm/blob/master/javademo/DAOProject/src/com/cfxyz/test/junit/IDeptServiceTest.java)��

