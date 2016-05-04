package com.cfxyz.demo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TestCollections {

	public static void main(String[] args) {
		List<String> all = new ArrayList<String>();
		Collections.addAll(all, "Hello", "World", "Guad", "Ocale");
		Collections.reverse(all);
		all.add("Hello");
		all.add("Hello");
		all.add("Hello");
		//forEach����������
//		all.forEach(System.out :: println);
		
		Stream<String> stream = all.stream(); //ȡ��Stream��Ķ���
//		System.out.println(stream.count()); //���ݸ���
//		System.out.println(stream.distinct().count()); //����ȥ��
		//ȥ�������е��ظ����ݺ��γ��µļ������ݣ������ǲ������ظ����ݵļ���
		List<String> newAll = stream.distinct().collect(Collectors.toList());
		newAll.forEach(System.out :: println);
		System.out.println("");
		
		//��ֻ�ܴ�һ��
		Stream<String> streamf = all.stream();
		List<String> fAll = streamf
				.distinct()
				.map((x) -> x.toLowerCase())
//				.skip(2)
//				.limit(2)
				.filter((x) -> x.contains("o"))
				.collect(Collectors.toList());
		fAll.forEach(System.out :: println);
		
		Predicate<String> p1 = (x)->x.contains("hello");
		Predicate<String> p2 = (x)->x.contains("ocale");		
		Stream<String> streamm = all.stream();
		if(streamm.anyMatch(p1.and(p2))) { //ͬʱ������������
			System.out.println("���ݶ����ڣ�");
		}
		
		//MapReduce
		System.out.println(all.stream()
				.map((x)->x.toLowerCase())
				.reduce((s1,s2)-> s1.concat(s2)).get());
	}

}
