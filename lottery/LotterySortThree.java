import java.util.*;

public class LotterySortThree {
    public static void main(String[] args) {

        int[] nums = LotterySortThree.EnterThreeNums();
        int[] randomNums = LotterySortThree.MakeRandomNums(3);

        System.out.println("Your Numbers:");
        for(int i: nums)
            System.out.print(i + " ");
        System.out.println();
    
        System.out.println("Lottery Numbers:");
        for(int i: randomNums)
            System.out.print(i + " ");
        System.out.println(); 
        
        int award = LotterySortThree.Run(nums, randomNums);
        System.out.printf("Your Win %d yuan!\n", award);
    }

    
    /*
     * Run 静态方法
     * 比较输入数组与中奖数组，返回中奖金额。
     */
    public static int Run(int[] nums, int[] winNums) {
        Set<Integer> set = new HashSet<Integer>();
        for(int n: winNums)
            set.add(n);
        
        int award = 0;
        
        if(Arrays.equals(nums, winNums) && set.size() == 3) {
            award = 1040;
            return award;
        }
        
        Arrays.sort(nums);
        Arrays.sort(winNums);
        
        if(Arrays.equals(nums, winNums)) {
            switch(set.size()) {
            case 1:
                award = 1040;
                break;
            case 2:
                award = 346;
                break;
            case 3:
                award = 173;
                break;
            }
        }
 
        return award;       
    }
    

    /*
     * MakeRandomNums 静态方法
     * 读取参数n，返回n个随机数字的数组
     */
    public static int[] MakeRandomNums(int n) {
        int[] randomNums = new int[n];
        for(int i=0; i<n; i++)
            randomNums[i] = (int)(Math.random() * 10);

        return randomNums;
    }


    /*
     * EnterThreeNums 静态方法
     * 从控制台读取输入的三个数字，返回这个数组
     */
    public static int[] EnterThreeNums() {
        Scanner in = new Scanner(System.in);
        
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
        
        return nums;
    }
}
