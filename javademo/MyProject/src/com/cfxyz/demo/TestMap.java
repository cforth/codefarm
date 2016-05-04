package com.cfxyz.demo;

import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

class BookM {
	private String title;
	public BookM(String title) {
		this.title = title;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookM other = (BookM) obj;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "BookM [title=" + title + "]";
	}
	
}

public class TestMap {

	public static void main(String[] args) {
		Map<String, Integer> map = new Hashtable<String, Integer>();
		map.put("Ҽ", 1);
		map.put("��", 2);
		map.put("��", 3);
		//��Map���ϱ�ΪSet���ϣ�Ŀ����Ϊ��ʹ��iterator����
		Set<Map.Entry<String, Integer>> set = map.entrySet();
		Iterator<Map.Entry<String, Integer>> iter = set.iterator();
		while(iter.hasNext()) {
			Map.Entry<String, Integer> me = iter.next();
			System.out.println(me.getKey() + " = " + me.getValue());
		}
		
		Map<BookM, String> book = new Hashtable<BookM, String>();
		book.put(new BookM("Java����"), "Java");
		book.put(new BookM("JSP����"), "JSP");
		book.put(new BookM("Oracle����"), "Oracle");

		Set<Map.Entry<BookM, String>> setb = book.entrySet();
		Iterator<Map.Entry<BookM, String>> iterb = setb.iterator();
		while(iterb.hasNext()) {
			Map.Entry<BookM, String> me = iterb.next();
			System.out.println(me.getKey() + " = " + me.getValue());
		}
	}

}
