import java.util.*;

public class LotterySortThree {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        
        //读取控制台输入的三个数字，用空格分开
        System.out.print("Enter Three numbers: ");
        String numStr = in.nextLine();
        String[] numArray = numStr.split(" ");
        
        //如果读取的数字数量不是三个，则报错
        if(numArray.length != 3){
            System.out.println("Not 3 num!");
            return;
        }
        
        //将读取的数字字符串转换为整型
        int[] nums = new int[3];
        try {
            for(int i=0; i<3; i++) {
                int num = Integer.parseInt(numArray[i]);
                if(num >= 10 || num < 0){
                    System.out.println("Must in 0 - 9!");
                    return;
                }
                nums[i] = num;
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        //随机生成三个数字
        int[] randomNums = new int[3];
        for(int i=0; i<3; i++)
            randomNums[i] = (int)(Math.random() * 10);
        
        for(int i: nums)
            System.out.print(i + " ");
        System.out.println();
        
        for(int i: randomNums)
            System.out.print(i + " ");
        System.out.println();
    }
}
