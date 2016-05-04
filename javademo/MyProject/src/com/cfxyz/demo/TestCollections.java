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
		//forEach接收消费类
//		all.forEach(System.out :: println);
		
		Stream<String> stream = all.stream(); //取得Stream类的对象
//		System.out.println(stream.count()); //数据个数
//		System.out.println(stream.distinct().count()); //数据去重
		//去除掉所有的重复数据后形成新的集合数据，里面是不包含重复内容的集合
		List<String> newAll = stream.distinct().collect(Collectors.toList());
		newAll.forEach(System.out :: println);
		System.out.println("");
		
		//流只能打开一次
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
		if(streamm.anyMatch(p1.and(p2))) { //同时满足两个条件
			System.out.println("数据都存在！");
		}
		
		//MapReduce
		System.out.println(all.stream()
				.map((x)->x.toLowerCase())
				.reduce((s1,s2)-> s1.concat(s2)).get());
	}

}
