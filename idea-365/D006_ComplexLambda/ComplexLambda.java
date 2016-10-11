package com.cfxyz.demo;

import java.util.Arrays;
import static java.util.Comparator.comparing;
import static java.util.stream.Collectors.toList;
import java.util.List;
import java.util.function.DoubleFunction;
import java.util.function.Function;
import java.util.function.Predicate;

import com.cfxyz.vo.Apple;

public class ComplexLambda {
    public static void main(String[] args) {
        List<Apple> inventory = Arrays.asList(new Apple(80, "green", "China"),
                                              new Apple(155, "red","USA"),
                                              new Apple(120, "red","USA"),
                                              new Apple(120, "green","UK"),
                                              new Apple(120, "red","China")) ;
        
        System.out.println("按照重量递减排序：") ; 
        inventory.stream()
                 .sorted(comparing(Apple::getWeight).reversed()) //比较器复合：逆序
                 .forEach(System.out::println) ;   //使用流来内部迭代
        
        //比较器复合：比较器链
        System.out.println("按照重量递减排序，如果重量相同按照国家排序：");
        inventory.stream()
                 .sorted(comparing(Apple::getWeight)
                 .reversed()
                 .thenComparing(Apple::getCountry))
                 .forEach(System.out::println) ; 

        System.out.println("表达要么是重（150克以上）的红苹果，要么是绿苹果：");
        //谓词复合
        Predicate<Apple> redApple = (                   //红色苹果Predicate对象
                a -> a.getColor().equals("red")) ; 
        Predicate<Apple> redAndHeavyAppleOrGreen =      //链接Predicate的方法来构造更复杂Predicate对象
                redApple.and(a -> a.getWeight() > 150)
                        .or(a -> "green".equals(a.getColor()));
        inventory.stream()                                  //获得流
                 .filter(redAndHeavyAppleOrGreen)           //使用过滤器获得Apple对象列表
                 .map(Apple::toString) 
                 .forEach(System.out::println) ;
        
        //函数复合
        Function<Integer, Integer> f = x -> x + 1 ;
        Function<Integer, Integer> g = x -> x * 2 ;
        Function<Integer, Integer> h = f.andThen(g) ; //数学上是g(f(x))
        System.out.println("===============================");
        System.out.println(h.apply(1)); //4
        
        h = f.compose(g); //数学上是f(g(x))
        System.out.println("===============================");
        System.out.println(h.apply(1)); //3
        
        //线性函数
        Function<Double, Double> fun = x -> x + 10 ;
        double result = integrate((double x) -> fun.apply(x), 3, 7) ;
        System.out.println("===============================");
        System.out.println(result); //60.0
    }
    
    /**
     * f是一个线性函数（直线）
     * @param f 函数式接口对象
     * @param a 参数1
     * @param b 参数2
     * @return (f(a)+f(b))*(b-a)/2.0
     */
    public static double integrate(DoubleFunction<Double> f, double a, double b) {
        return (f.apply(a) + f.apply(b)) * (b-a) / 2.0;
    }
}

