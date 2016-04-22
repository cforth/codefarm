package com.cfxyz.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.cfxyz.vo.Emp;

/**
 * ����emp���ҵ����ִ�б�׼������һ��Ҫ�������ݿ�Ĵ���رղ���;
 * �������ͨ��DAOFactory��ȡ��IEmpDAO�ӿڶ���
 *
 */
public interface IEmpService {
	/**
	 * ʵ�ֹ�Ա���ݵ����Ӳ��������β���Ҫ����IEmpDAO�ӿڵ����·���;
	 * ��Ҫ����IEmpDAO.findByID()�������ж�Ҫ�������ݵ�id�Ƿ��Ѵ���;
	 * �������Ҫ���ӵ����ݱ�Ų����������IEmpDAO.doCreate()���������ز������;
	 * @param vo ������Ҫ�������ݵ�VO����
	 * @return ����������ݵ�ID�ظ����߱���ʧ�ܷ���false�����򷵻�true
	 * @throws Exception SQLִ���쳣
	 */
	public boolean insert(Emp vo) throws Exception ;
	
	/**
	 * ʵ�ֹ�Ա���ݵ��޸Ĳ���������Ҫ����IEmpDAO.doUpdate()�����������޸�����ȫ�����ݵ��޸�
	 * @param vo ������Ҫ�޸����ݵ�VO����
	 * @return �޸ĳɹ�����true�����򷵻�false
	 * @throws Exception SQLִ���쳣
	 */
	public boolean update(Emp vo) throws Exception ;
	
	/**
	 * ִ�й�Ա���ݵ�ɾ������������ɾ�������Ա��Ϣ������IEmpDAO.doRemoveBatch()����
	 * @param ids ������ȫ��Ҫɾ�����ݵļ��ϣ�û���ظ�����
	 * @return ɾ���ɹ�����true�����򷵻�false
	 * @throws Exception SQLִ���쳣
	 */
	public boolean delete(Set<Integer> ids) throws Exception ;
	
	/**
	 * ���ݹ�Ա��Ų��ҹ�Ա��������Ϣ������IEmpDAO.findById()����
	 * @param ids Ҫ���ҵĹ�Ա���
	 * @return ����ҵ��˹�Ա��Ϣ��VO���󷵻أ����򷵻�null
	 * @throws Exception SQLִ���쳣
	 */
	public Emp get(int ids) throws Exception ;
	
	/**
	 * ��ѯȫ����Ա��Ϣ������IEmpDAO.findAll()����
	 * @return ��ѯ�����List���ϵ���ʽ���أ����û�������򼯺ϵĳ���Ϊ0
	 * @throws Exception SQLִ���쳣
	 */
	public List<Emp> list() throws Exception ;
	
	/**
	 * ʵ�����ݵ�ģ����ѯ������ͳ�ƣ�Ҫ����IEmpDAO�ӿڵ���������;
	 * ����IEmpDAO.findAllSplit()��������ѯ�����еı����ݣ����ص�List;
	 * ����IEmpDAO.getAllSplit()��������ѯ���е�������������Integer
	 * @param currentPage ��ǰ����ҳ
	 * @param lineSize ÿҳ��ʾ�ļ�¼��
	 * @param column ģ����ѯ��������
	 * @param keyWord ģ����ѯ�ؼ���
	 * @return ������������Ҫ���ض����������ͣ�����ʹ��Map���Ϸ��أ��������Ͳ�ͳһ����������value����������ΪObject����;
	 * key = allEmps, value = IEmpDAO.findAllSplit()���ؽ����List;
	 * key = empCount, value = IEmpDAO.getAllCount()���ؽ����Integer
	 * @throws Exception SQLִ���쳣
	 */
	public Map<String, Object> list(int currentPage, int lineSize, String column, String keyWord) throws Exception ;
}
