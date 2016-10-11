package com.cfxyz.demo;

import java.util.function.Function;
import java.util.stream.LongStream;
import java.util.stream.Stream;

public class ParallelStreamsTest {
    public static void main(String[] args) {
        System.setProperty("java.util.concurrent.ForkJoinPool.common.parallelism","4"); //对应处理器的核心数
        System.out.println("Iterative sum done in:" +
                measureSumPerf(ParallelStreamsTest::iterativeSum, 10_000_000) + " msecs");
        System.out.println("Sequential sum done in:" +
                measureSumPerf(ParallelStreamsTest::sequentialSum, 10_000_000) + " msecs");
//      System.out.println("parallel sum done in:" +
//              measureSumPerf(ParallelStreamsTest::parallelSum, 10_000_000) + " msecs");
        System.out.println("rangedSum sum done in:" +
                measureSumPerf(ParallelStreamsTest::rangedSum, 10_000_000) + " msecs");
    }
    
    /**
     * 使用传统的for循环累加
     * @param n
     * @return
     */
    public static long iterativeSum(long n) { 
        long result = 0;
        for (long i = 1L; i <= n; i++) {
            result += i;
        }
        return result;
    }
    
    /**
     * 使用普通流
     * @param n
     * @return
     */
    public static long sequentialSum(long n) {  
        return Stream.iterate(1L, i -> i + 1)    //生成自然数无限流
                     .limit(n)    //限制到前n个数
                     .reduce(0L, Long::sum);    //对所有数字求和来归纳流
    }
    
    /**
     * 使用并行流，iterate方法本质是顺序的，所以无法发挥并行优势
     * @param n
     * @return
     */
    public static long parallelSum(long n) {
        return Stream.iterate(1L, i -> i + 1)
                .limit(n)
                .parallel()     //将流转换为并行流
                .reduce(0L, Long::sum) ;
    }
    
    /**
     * 使用并行流,使用rangeClosed方法省掉装拆箱的时间
     * @param n
     * @return
     */
    public static long rangedSum(long n) {
        return LongStream.rangeClosed(1, n)
                .reduce(0L, Long::sum) ;
    }
    
    /**
     * 测试方法
     * @param adder
     * @param n
     * @return
     */
    public static long measureSumPerf(Function<Long, Long> adder, long n) {
        long fastest = Long.MAX_VALUE;
        for (int i = 0; i < 10; i++) {
            long start = System.nanoTime();
            long sum = adder.apply(n);
            long duration = (System.nanoTime() - start) / 1_000_000;
            System.out.println("Result: " + sum);
            if (duration < fastest) fastest = duration;
        }
        return fastest;
    }
}

