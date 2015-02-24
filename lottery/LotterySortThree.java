import java.util.*;

public class LotterySortThree {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        
        //读取控制台输入的三个数字，用空格分开
        System.out.print("Enter Three numbers: ");
        String numStr = in.nextLine();
        numStr = numStr.trim().replaceAll("\\s{1,}", " ");
        
        if (false == numStr.matches("^\\d\\s\\d\\s\\d$")) {
            System.out.println("Not 3 num!");
            System.exit(-1);
        }
        
        String[] numArray = numStr.split(" ");
        int[] nums = new int[3];
        
        for(int i=0; i<3; i++)
            nums[i] = Integer.parseInt(numArray[i]);
        
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
