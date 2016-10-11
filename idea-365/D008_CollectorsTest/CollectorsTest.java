package com.cfxyz.demo;

import static java.util.stream.Collectors.*;

import java.util.Arrays;
import java.util.Comparator;
import java.util.IntSummaryStatistics;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.cfxyz.util.ToListCollector;
import com.cfxyz.vo.Dish;

public class CollectorsTest {
    public enum CaloricLevel { DIET, NORMAL, FAT }
    
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
        
        // 创建一个Comparator来根据所含热量对菜肴进行比较
        Comparator<Dish> dishCaloriesComparator =
                Comparator.comparingInt(Dish::getCalories) ;
        
        //传给Collectors.maxBy
        Optional<Dish> mostCalorieDish =
                menu.stream()
                    .collect(maxBy(dishCaloriesComparator));
        System.out.println(mostCalorieDish);
        
        //收集器 汇总求和
        int totalCalories = menu
                .stream()
                .collect(summingInt(Dish::getCalories)); //使用静态方法Collectors.summintInt进行汇总求和
        System.out.println(totalCalories);
        System.out.println(menu
                .stream()
                .map(Dish::getCalories)         //使用map获得卡路里流
                .reduce(0, (a,b) -> a + b));    //使用reduce规约求和
        
        //收集器 汇总求平均值
        double avgCalories = menu
                .stream()
                .collect(averagingInt(Dish::getCalories)); 
        System.out.println(avgCalories);
        
        //收集器 统计值
        IntSummaryStatistics menuStatistics = menu
                .stream()
                .collect(summarizingInt(Dish::getCalories)) ;
        System.out.println(menuStatistics);
        
        //连接字符串
        String shortMenu = menu
                .stream()
                .map(Dish::getName)
                .collect(joining(", "));
        System.out.println(shortMenu);
        
        //广义规约汇总 求和
        System.out.println(menu
                .stream()
                .collect(reducing(0, Dish::getCalories, (i, j) -> i + j)));
    
        //分组
        Map<Dish.Type, List<Dish>> dishesByType =
                menu.stream().collect(groupingBy(Dish::getType));
        System.out.println(dishesByType);
        
        //分组
        Map<CaloricLevel, List<Dish>> dishesByCaloricLevel = menu.stream().collect(
                groupingBy(dish -> {
                       if (dish.getCalories() <= 400) return CaloricLevel.DIET;
                       else if (dish.getCalories() <= 700) return
            CaloricLevel.NORMAL;
                else return CaloricLevel.FAT;
                 } ));
        System.out.println(dishesByCaloricLevel);
        
        Map<Dish.Type, Optional<Dish>> mostCaloricByType =
                menu.stream()
                    .collect(groupingBy(Dish::getType,
                                        maxBy(Comparator.comparingInt(Dish::getCalories))));
        System.out.println("按照热量最高的菜肴分组:" + mostCaloricByType);
        
        //测试自己的toList收集器
        List<Integer> numbers = Arrays.asList(1,2,1,3,3,2,4) ;
        List<Integer> nums = numbers.stream()
              .filter(i -> i % 2 == 0)
              .distinct()
              .collect(new ToListCollector<Integer>());
        System.out.println(nums);        

    }
}

