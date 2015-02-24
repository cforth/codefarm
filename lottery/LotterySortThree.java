import java.util.*;

public class LotterySortThree {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        
        //读取控制台输入的三个数字，用空格分开
        System.out.print("Enter Three numbers: ");
        String numStr = in.nextLine();
        numStr = numStr.replaceAll("\\s{1,}", " ");
        String[] numArray = numStr.split(" ");
        
        //如果读取的数字数量不是三个，则报错
        if(numArray.length != 3){
            System.out.println("Not 3 num!");
            System.exit(-1);
        }
        
        //将读取的数字字符串转换为整型
        int[] nums = new int[3];

        for(int i=0; i<3; i++) {
            int num = 0;
            char[] arr = numArray[i].toCharArray();
            
            //检测每个字符是否为数字字符
            for(char a: arr){
                if(a >= '0' && a <= '9'){
                    num = num * 10 + (a - '0');
                }else{
                    System.out.println("Not num!");
                    System.exit(-1);
                }
            }

            //检测数是否在0到9之间
            if(num >= 10 || num < 0){
                System.out.println("Must in 0 - 9!");
                System.exit(-1);
            }
            nums[i] = num;
        }
        
        //随机生成三个数字
        int[] randomNums = new int[3];
        for(int i=0; i<3; i++)
            randomNums[i] = (int)(Math.random() * 10);
        
        System.out.println("Your Numbers:");
        for(int i: nums)
            System.out.print(i + " ");
        System.out.println();
        
        System.out.println("Lottery Numbers:");
        for(int i: randomNums)
            System.out.print(i + " ");
        System.out.println();
    }
}
