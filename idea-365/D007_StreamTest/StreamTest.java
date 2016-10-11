package com.cfxyz.demo;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.function.IntSupplier;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import com.cfxyz.vo.Dish;

public class StreamTest {
    public static void main(String[] args) {
        List<Dish> menu = Arrays.asList(
                new Dish("pork", false, 800, Dish.Type.MEAT),
                new Dish("beef", false, 700, Dish.Type.MEAT),
                new Dish("chicken", false, 400, Dish.Type.MEAT),
                new Dish("french fries", true, 530, Dish.Type.OTHER),
                new Dish("rice", true, 350, Dish.Type.OTHER),
                new Dish("season fruit", true, 120, Dish.Type.OTHER),
                new Dish("pizza", true, 550, Dish.Type.OTHER),
                new Dish("prawns", false, 300, Dish.Type.FISH),
                new Dish("salmon", false, 450, Dish.Type.FISH) );
        
        //选出高热量，前三个菜肴的名字列表
        menu.stream()
            .filter(d -> d.getCalories() > 300)
            .map(Dish::getName)
            .limit(3)
            .forEach(System.out::println);
        
        System.out.println("筛选出列表中的偶数，并且不能有重复:");
        List<Integer> numbers = Arrays.asList(1,2,1,3,3,2,4) ;
        numbers.stream()
              .filter(i -> i % 2 == 0)
              .distinct()               //消除重复
              .forEach(System.out::println) ;
        
        System.out.println("截断流：");
        menu.stream()
        .filter(d -> d.getCalories() > 300)
        .limit(3)                       //截断前3个
        .forEach(System.out::println);
        
        System.out.println("跳过元素：");
        menu.stream()
        .filter(d -> d.getCalories() > 300)
        .skip(2)                        //跳过前两个
        .forEach(System.out::println);
        
        System.out.println("流的扁平化");
        String[] arrayOfWords = {"Goodbye", "World"};
        List<String> uniqueCharacters = Arrays
                .asList(arrayOfWords)
                .stream()
                .map(w -> w.split(""))   //将每个单词转换为字母组成的数组
                .flatMap(Arrays::stream) //将各个生成流扁平化为单个流
                .distinct()
                .collect(Collectors.toList()) ;
        System.out.println(uniqueCharacters);
        
        System.out.println("检查谓词是否至少匹配一个元素");
        if(menu.stream().anyMatch(Dish::isVegetarian)){
            System.out.println("The menu is (somewhat) vegetarian friendly!!");
        }
        
        System.out.println("查找元素：");
        Optional<Dish> dish = //Optional<T>类（java.util.Optional）是一个容器类，代表一个值存在或不存在
                menu.stream()
                    .filter(Dish::isVegetarian)
                    .findAny();
        dish.ifPresent(d -> System.out.println(d.getName()));
        
        System.out.println("元素求和：");
        int sum = numbers.stream().reduce(0, Integer::sum) ;
        System.out.println(sum);
        
        System.out.println("元素求和 并行版：");
        sum = numbers.parallelStream().reduce(0, Integer::sum) ;
        System.out.println(sum);
        
        System.out.println("map reduce:");
        int count = menu.stream()
                .map(d -> 1)
                .reduce(0, (a, b) -> a + b);
        System.out.println(count);
        
        int calories = menu.stream()    //返回一个Stream<Dish>
        .mapToInt(Dish::getCalories)    //返回一个IntStream
        .sum();
        System.out.println("映射到数值流：" + calories);
        
        Stream<int[]> pythagoreanTriples =
                IntStream.rangeClosed(1, 100).boxed()
                         .flatMap(a ->
                             IntStream.rangeClosed(a, 100)
                                      .filter(b -> Math.sqrt(a*a + b*b) % 1 == 0)
                                      .mapToObj(b ->
                                          new int[]{a, b, (int)Math.sqrt(a * a + b * b)})
                                 );
        System.out.println("100以内的勾股数前5个：" );
        pythagoreanTriples.limit(5)
        .forEach(t ->
            System.out.println(t[0] + ", " + t[1] + ", " + t[2]));
        
        Stream<double[]> pythagoreanTriples2 =
                IntStream.rangeClosed(1, 100).boxed()
                         .flatMap(a ->
                             IntStream.rangeClosed(a, 100)
                                      .mapToObj(
                                          b -> new double[]{a, b, Math.sqrt(a*a + b*b)})    //产生三元数
                                      .filter(t -> t[2] % 1 == 0));    //元组中的第三个元素必须是整数
        System.out.println("100以内的勾股数前5个：" );
        pythagoreanTriples2.limit(5)
        .forEach(t ->
            System.out.println(t[0] + ", " + t[1] + ", " + t[2]));
        
        //由文件生成流
        long uniqueWords = 0;
        try(Stream<String> lines =
                  Files.lines(Paths.get("F://temp//data.txt"), Charset.defaultCharset())){    //流会自动关闭
            uniqueWords = lines.flatMap(line -> Arrays.stream(line.split(" ")))    //生成单词流
                           .distinct()    //删除重复项
                           .count();    //数一数有多少各不相同的单词
        }
        catch(Exception e){
                              //如果打开文件时出现异常则加以处理
        }
        System.out.println(uniqueWords);
        
        System.out.println("生成无限流：");
        Stream.iterate(0, n -> n + 2)
          .limit(10)            //不截断的话会无限输出
          .forEach(System.out::println);
        
        System.out.println("生成菲波那切数列：");
        Stream.iterate(new int[]{0,1}, 
                        t -> new int[]{t[1],t[0]+t[1]})
                .limit(10)
                .map(t -> t[0])
                .forEach(System.out::println);
        
        System.out.println("生成菲波那切数列：");
        IntSupplier fib = new IntSupplier(){
            private int previous = 0;
            private int current = 1;
            public int getAsInt(){
                int oldPrevious = this.previous;
                int nextValue = this.previous + this.current;
                this.previous = this.current;
                this.current = nextValue;
                return oldPrevious;
            }
        };
        IntStream.generate(fib).limit(10).forEach(System.out::println);
    }
}

