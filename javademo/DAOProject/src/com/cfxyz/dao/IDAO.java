package com.cfxyz.dao;

import java.util.List;
import java.util.Set;

/**
 * ���幫����DAO�����ӿڱ�׼�������Ĺ��ܰ��������ӡ��޸�ȫ����ɾ�����ݡ����ݱ�Ų�ѯ����ѯȫ������ҳ��ʾ������ͳ��
 * @param <K> ��ʾҪ�������������ͣ����ӽӿ�ʵ��
 * @param <V> ��ʾҪ������VO���ͣ����ӽӿ�ʵ��
 */
public interface IDAO<K, V> {
	/**
	 * ʵ�����ݵ����Ӳ���
	 * @param vo ������Ҫ���ӵ����ݵ�VO����
	 * @return ���ݱ���ɹ�����true�����򷵻�false
	 * @throws Exception SQLִ���쳣
	 */
	public boolean doCreate(V vo) throws Exception ;
	
	/**
	 * ʵ�����ݵ��޸Ĳ����������޸��Ǹ���id����ȫ���ֶ����ݵ��޸�
	 * @param vo ������Ҫ�޸����ݵ���Ϣ��һ��Ҫ�ṩ��ID����
	 * @return �����޸ĳɹ�����true�����򷵻�false
	 * @throws Exception SQLִ���쳣
	 */
	public boolean doUpdate(V vo) throws Exception ;
	
	/**
	 * ִ�����ݵ�����ɾ������������Ҫɾ����������Set���ϵ���ʽ����
	 * @param ids ����������Ҫɾ��������ID�����������ظ�����
	 * @return ɾ���ɹ�����true��ɾ�������ݸ�����Ҫɾ�������ݸ�����ͬ�������򷵻�false
	 * @throws Exception SQLִ���쳣
	 */
	public boolean doRemoveBatch(Set<K> ids) throws Exception ;
	
	/**
	 * ���ݹ�Ա��Ų�ѯָ������Ϣ
	 * @param id Ҫ��ѯ�ı��
	 * @return �����Ϣ���ڣ���������VO��������ʽ���أ������Ա�����ڷ���null
	 * @throws Exception SQLִ���쳣
	 */
	public V findById(K id) throws Exception ;

	/**
	 * ��ѯָ�����ݱ��ȫ����¼�������Լ��ϵ���ʽ����
	 * @return ������������ݣ������е����ݻ��װΪVO�����������List���Ϸ��أ�
	 * ���û�����ݣ���ô���ϵĳ���Ϊ0��size() == 0,����null��
	 * @throws Exception SQLִ���쳣
	 */
	public List<V> findAll() throws Exception ;
	
	/**
	 * ��ҳ�������ݵ�ģ����ѯ����ѯ����Լ��ϵ���ʽ����
	 * @param currentPage ��ʾ��ǰ���ڵ�ҳ
	 * @param lineSize ÿҳ��ʾ����������
	 * @param column Ҫ����ģ����ѯ��������
	 * @param keyWord ģ����ѯ�Ĺؼ���
	 * @return ������������ݣ������е����ݻ��װΪVO�����������List���Ϸ��أ�
	 * ���û�����ݣ���ô���ϵĳ���Ϊ0��size() == 0,����null��
	 * @throws Exception SQLִ���쳣
	 */
	public List<V> findAllSplit(Integer currentPage, Integer lineSize, String column, String keyWord) throws Exception ;

	/**
	 * ����ģ����ѯ��������ͳ�ƣ��������û�м�¼ͳ�ƵĽ������0
	 * @param column Ҫ����ģ����ѯ��������
	 * @param keyWord ģ����ѯ�Ĺؼ���
	 * @return ���ر��е������������û�����ݷ���0
	 * @throws Exception SQLִ���쳣
	 */
	public Integer getAllCount(String column, String keyWord) throws Exception ;
}
